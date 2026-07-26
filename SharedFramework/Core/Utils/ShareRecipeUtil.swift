//
//  ShareRecipeUtil.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import Foundation
import SwiftUI
import UIKit
import os

struct ShareRecipeUtil {
    static let shared = ShareRecipeUtil()

    func shareRecipeAsPDF(
        recipe: RecipeModel,
        onSuccess: () -> Void,
        onError: (String) -> Void
            // isLoading: Binding<Bool>? = nil
    ) async {

        let image = await downloadImage(
            from: recipe.image,
            onSuccess: {
                // onSuccess()
            },
            onError: { error in
                onError(error)
            }
        )

        if let pdfURL = createRecipePDF(recipe: recipe, image: image) {
            DispatchQueue.main.async {
                sharePDF(url: pdfURL)
            }
            onSuccess()
        }
        else {
            os.Logger().debug("Failed to create PDF")
            onError("Failed to create PDF")
        }
    }

    func downloadImage(
        from urlString: String,
        onSuccess: () -> Void,
        onError: (String) -> Void
    ) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
            onSuccess()
        }
        catch {
            os.Logger().debug("Image download failed: \(error)")
            onError(error.localizedDescription)
            return nil
        }
    }

    func createRecipePDF(recipe: RecipeModel, image: UIImage?) -> URL? {
        let pageWidth: CGFloat = 595.2
        let pageHeight: CGFloat = 841.8
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

        let metadata: [String: Any] = [
            kCGPDFContextCreator as String: "RecipeApp",
            kCGPDFContextAuthor as String: recipe.chef?.name ?? "Awesome Chef!"
        ]

        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = metadata

        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        let tempDir = FileManager.default.temporaryDirectory
        let pdfURL = tempDir.appendingPathComponent("\(recipe.name.replacingOccurrences(of: " ", with: "_")).pdf")

        do {
            try renderer.writePDF(to: pdfURL) { context in
                drawRecipePDF(
                    recipe: recipe,
                    image: image,
                    context: context,
                    pageRect: pageRect
                )
            }
            return pdfURL
        }
        catch {
            os.Logger().debug("Could not create PDF: \(error)")
            return nil
        }
    }

    private func drawRecipePDF(
        recipe: RecipeModel,
        image: UIImage?,
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect
    ) {
        var yOffset: CGFloat = 30
        let margin: CGFloat = 24

        let titleFont = UIFont.systemFont(ofSize: 26, weight: .bold)
        let sectionFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
        let contentFont = UIFont.systemFont(ofSize: 16)
        let smallFont = UIFont.systemFont(ofSize: 14)

        drawAppHeader(context: context, yOffset: &yOffset, pageRect: pageRect)
        drawRecipeTitle(recipe.name, font: titleFont, yOffset: &yOffset, pageRect: pageRect)

        drawRecipeImage(image, yOffset: &yOffset, context: context, pageRect: pageRect)

        drawDescription(recipe.description, font: contentFont, yOffset: &yOffset, pageRect: pageRect)

        if let chef = recipe.chef {
            drawChefDetails(chef, yOffset: &yOffset, pageRect: pageRect, smallFont: smallFont)
        }

        drawIngredients(
            recipe.ingredients,
            yOffset: &yOffset,
            context: context,
            pageRect: pageRect,
            contentFont: contentFont
        )

        drawInstructions(
            recipe.inststuctionsList,
            yOffset: &yOffset,
            context: context,
            pageRect: pageRect,
            contentFont: contentFont
        )
    }

    private func drawText(
        _ text: String,
        font: UIFont,
        x: CGFloat,
        y: inout CGFloat,
        width: CGFloat,
        spacing: CGFloat = 12
    ) {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let attrString = NSAttributedString(string: text, attributes: attributes)
        let boundingRect = attrString.boundingRect(
            with: CGSize(width: width, height: .infinity),
            options: [.usesLineFragmentOrigin],
            context: nil
        )
        attrString.draw(in: CGRect(x: x, y: y, width: width, height: boundingRect.height))
        y += boundingRect.height + spacing
    }

    private func startNewPageIfNeeded(
        neededSpace: CGFloat,
        yOffset: inout CGFloat,
        context: UIGraphicsPDFRendererContext,
        pageHeight: CGFloat
    ) {
        if yOffset + neededSpace > pageHeight - 60 {
            context.beginPage()
            yOffset = 30
        }
    }

    private func drawAppHeader(
        context: UIGraphicsPDFRendererContext,
        yOffset: inout CGFloat,
        pageRect: CGRect
    ) {
        let margin: CGFloat = 24
        if let icon = UIImage(named: "AppIcon") {
            let iconSize: CGFloat = 40
            let rect = CGRect(x: margin, y: yOffset, width: iconSize, height: iconSize)
            icon.draw(in: rect)
        }

        let sectionFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
        drawText(
            "RecipeApp",
            font: sectionFont,
            x: margin + 50,
            y: &yOffset,
            width: pageRect.width - 2 * margin - 50,
            spacing: 16
        )
    }

    private func drawRecipeTitle(
        _ title: String,
        font: UIFont,
        yOffset: inout CGFloat,
        pageRect: CGRect
    ) {
        let margin: CGFloat = 24
        drawText(
            title,
            font: font,
            x: margin,
            y: &yOffset,
            width: pageRect.width - 2 * margin,
            spacing: 20
        )
    }

    private func drawRecipeImage(
        _ image: UIImage?,
        yOffset: inout CGFloat,
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect
    ) {
        guard let image = image else { return }

        let margin: CGFloat = 24
        let maxWidth = pageRect.width - 2 * margin
        let aspectRatio = image.size.width / image.size.height
        let imageHeight = maxWidth / aspectRatio

        startNewPageIfNeeded(
            neededSpace: imageHeight + 20,
            yOffset: &yOffset,
            context: context,
            pageHeight: pageRect.height
        )

        let imageRect = CGRect(x: margin, y: yOffset, width: maxWidth, height: imageHeight)
        let path = UIBezierPath(roundedRect: imageRect, cornerRadius: 16)
        path.addClip()
        image.draw(in: imageRect)
        yOffset += imageHeight + 20
    }

    private func drawDescription(
        _ description: String,
        font: UIFont,
        yOffset: inout CGFloat,
        pageRect: CGRect
    ) {
        let margin: CGFloat = 24
        drawText(
            description,
            font: font,
            x: margin,
            y: &yOffset,
            width: pageRect.width - 2 * margin,
            spacing: 30
        )
    }

    private func drawChefDetails(
        _ chef: UserModel,  // Assume Chef model with name, email, phone?, rate?
        yOffset: inout CGFloat,
        pageRect: CGRect,
        smallFont: UIFont
    ) {
        let margin: CGFloat = 24
        let sectionFont = UIFont.systemFont(ofSize: 20, weight: .semibold)

        drawText(
            "👨‍🍳 Chef: \(chef.name)",
            font: sectionFont,
            x: margin,
            y: &yOffset,
            width: pageRect.width - 2 * margin,
            spacing: 4
        )

        drawText(
            "📧 Email: \(chef.email)",
            font: smallFont,
            x: margin,
            y: &yOffset,
            width: pageRect.width - 2 * margin,
            spacing: 2
        )

        if let phone = chef.phone {
            drawText(
                "📞 Phone: \(phone)",
                font: smallFont,
                x: margin,
                y: &yOffset,
                width: pageRect.width - 2 * margin,
                spacing: 2
            )
        }

        if let rate = chef.rate {
            drawText(
                "⭐ Rating: \(rate.ratingFormatted)/5",
                font: smallFont,
                x: margin,
                y: &yOffset,
                width: pageRect.width - 2 * margin,
                spacing: 16
            )
        }
        yOffset += 10
    }

    private func drawIngredients(
        _ ingredients: [IngredientModel],  // Assume Ingredient model
        yOffset: inout CGFloat,
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect,
        contentFont: UIFont
    ) {
        let margin: CGFloat = 24

        drawText(
            "🧄 Ingredients",
            font: UIFont.systemFont(ofSize: 20, weight: .semibold),
            x: margin,
            y: &yOffset,
            width: pageRect.width - 2 * margin,
            spacing: 10
        )

        drawSectionLine(context: context, yOffset: &yOffset, pageRect: pageRect)
        yOffset += 20

        for ingredient in ingredients {
            startNewPageIfNeeded(
                neededSpace: 30,
                yOffset: &yOffset,
                context: context,
                pageHeight: pageRect.height
            )
            drawText(
                "• \(ingredient.name): \(ingredient.quantity)",
                font: contentFont,
                x: margin + 10,
                y: &yOffset,
                width: pageRect.width - 2 * margin - 10
            )
        }
        yOffset += 20
    }

    private func drawInstructions(
        _ instructions: [String],
        yOffset: inout CGFloat,
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect,
        contentFont: UIFont
    ) {
        let margin: CGFloat = 24

        drawText(
            "📋 Instructions",
            font: UIFont.systemFont(ofSize: 20, weight: .semibold),
            x: margin,
            y: &yOffset,
            width: pageRect.width - 2 * margin,
            spacing: 10
        )

        drawSectionLine(context: context, yOffset: &yOffset, pageRect: pageRect)
        yOffset += 20

        for (index, step) in instructions.enumerated() {
            startNewPageIfNeeded(
                neededSpace: 60,
                yOffset: &yOffset,
                context: context,
                pageHeight: pageRect.height
            )
            drawText(
                "\(index + 1). \(step)",
                font: contentFont,
                x: margin + 10,
                y: &yOffset,
                width: pageRect.width - 2 * margin - 10
            )
        }
    }

    private func drawSectionLine(
        context: UIGraphicsPDFRendererContext,
        yOffset: inout CGFloat,
        pageRect: CGRect
    ) {
        context.cgContext.setStrokeColor(UIColor.lightGray.cgColor)
        context.cgContext.setLineWidth(1)
        context.cgContext.move(to: CGPoint(x: 24, y: yOffset))
        context.cgContext.addLine(to: CGPoint(x: pageRect.width - 24, y: yOffset))
        context.cgContext.strokePath()
    }

    func sharePDF(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let rootVC = windowScene.windows.first?.rootViewController
        {
            rootVC.present(activityVC, animated: true)
        }
    }
}
