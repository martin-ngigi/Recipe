//
//  ShareRecipeUtil.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import Foundation

import UIKit
import SwiftUI

struct ShareRecipeUtil {
    static let shared = ShareRecipeUtil()
    
    // MARK: - Share Recipe as PDF
     
    func shareRecipeAsPDF(
        recipe: RecipeModel,
        onSuccess: () -> Void,
        onError: (String) -> Void
        //isLoading: Binding<Bool>? = nil
    ) async {
        
        let image = await downloadImage(
            from: recipe.image,
            onSuccess: {
                //onSuccess()
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
         } else {
             print("Failed to create PDF")
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
        } catch {
            print("Image download failed: \(error)")
            onError(error.localizedDescription)
            return nil
        }
    }
    
    // MARK: - Create PDF
    
    func createRecipePDF(recipe: RecipeModel, image: UIImage?) -> URL? {
        let pageWidth: CGFloat = 595.2
        let pageHeight: CGFloat = 841.8
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let metadata = [
            kCGPDFContextCreator: "RecipeApp",
            kCGPDFContextAuthor: recipe.chef?.name ?? "Awesome Chef!"
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = metadata as [String: Any]
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let tempDir = FileManager.default.temporaryDirectory
        let pdfURL = tempDir.appendingPathComponent("\(recipe.name.replacingOccurrences(of: " ", with: "_")).pdf")
        
        do {
            try renderer.writePDF(to: pdfURL, withActions: { context in
                context.beginPage()
                var yOffset: CGFloat = 30
                let margin: CGFloat = 24
                
                // MARK: - Fonts
                let titleFont = UIFont.systemFont(ofSize: 26, weight: .bold)
                let sectionFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
                let contentFont = UIFont.systemFont(ofSize: 16)
                
                func drawText(_ text: String, font: UIFont, x: CGFloat, y: inout CGFloat, width: CGFloat, spacing: CGFloat = 12) {
                    let attr = NSAttributedString(string: text, attributes: [.font: font])
                    let bounding = attr.boundingRect(with: CGSize(width: width, height: .infinity), options: .usesLineFragmentOrigin, context: nil)
                    attr.draw(in: CGRect(x: x, y: y, width: width, height: bounding.height))
                    y += bounding.height + spacing
                }
                
                func startNewPageIfNeeded(_ neededSpace: CGFloat) {
                    if yOffset + neededSpace > pageHeight - 60 {
                        context.beginPage()
                        yOffset = 30
                    }
                }
                
                // MARK: - Title
                drawText(recipe.name, font: titleFont, x: margin, y: &yOffset, width: pageRect.width - 2 * margin, spacing: 20)
                
                // MARK: - Image
                if let image = image {
                    let maxWidth = pageRect.width - 2 * margin
                    let aspectRatio = image.size.width / image.size.height
                    let imageHeight = maxWidth / aspectRatio
                    startNewPageIfNeeded(imageHeight + 20)
                    let imageRect = CGRect(x: margin, y: yOffset, width: maxWidth, height: imageHeight)
                    image.draw(in: imageRect)
                    yOffset += imageHeight + 20
                }
                
                // MARK: - Description
                drawText(recipe.description, font: contentFont, x: margin, y: &yOffset, width: pageRect.width - 2 * margin, spacing: 30)
                
                // MARK: - Ingredients Header
                drawText("🧄 Ingredients", font: sectionFont, x: margin, y: &yOffset, width: pageRect.width - 2 * margin, spacing: 10)
                context.cgContext.setStrokeColor(UIColor.lightGray.cgColor)
                context.cgContext.setLineWidth(1)
                context.cgContext.move(to: CGPoint(x: margin, y: yOffset))
                context.cgContext.addLine(to: CGPoint(x: pageRect.width - margin, y: yOffset))
                context.cgContext.strokePath()
                yOffset += 20
                
                // MARK: - Ingredients List
                for ingredient in recipe.ingredients {
                    startNewPageIfNeeded(30)
                    drawText("• \(ingredient.name): \(ingredient.quantity)", font: contentFont, x: margin + 10, y: &yOffset, width: pageRect.width - 2 * margin - 10)
                }
                yOffset += 20
                
                // MARK: - Instructions Header
                drawText("📋 Instructions", font: sectionFont, x: margin, y: &yOffset, width: pageRect.width - 2 * margin, spacing: 10)
                context.cgContext.setStrokeColor(UIColor.lightGray.cgColor)
                context.cgContext.setLineWidth(1)
                context.cgContext.move(to: CGPoint(x: margin, y: yOffset))
                context.cgContext.addLine(to: CGPoint(x: pageRect.width - margin, y: yOffset))
                context.cgContext.strokePath()
                yOffset += 20
                
                // MARK: - Instruction Steps
                for (i, step) in recipe.inststuctionsList.enumerated() {
                    startNewPageIfNeeded(60)
                    drawText("\(i + 1). \(step)", font: contentFont, x: margin + 10, y: &yOffset, width: pageRect.width - 2 * margin - 10)
                }
            })
            return pdfURL
        } catch {
            print("Could not create PDF: \(error)")
            return nil
        }
    }
    
    // MARK: - Present Share Sheet
    
    func sharePDF(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
}


