/*
* Created by Martin Wainaina on 13/09/2026
* Enhanced 27/09/2026 — HIG-inspired PDF layout, brand accent, bug fixes.
* Revised 27/09/2026 — fixed ingredient row overlap, full-bleed hero image,
* grouped-list card styling closer to native iOS lists (Reminders/Notes).
*
* Feel free to contribute.
*/

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

// MARK: - Brand / theme

private extension UIColor {
    /// Convenience init for hex strings like "#C4544A" or "C4544A".
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var sanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        sanitized = sanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: sanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

private extension UIFont {
    /// SF Pro Rounded when available, falling back to standard system font.
    /// Rounded numerals/letterforms read warmer — closer to Apple's food &
    /// wellness apps (Fitness, Food Noter, Reminders' friendly headers).
    static func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let base = UIFont.systemFont(ofSize: size, weight: weight)
        guard let descriptor = base.fontDescriptor.withDesign(.rounded) else { return base }
        return UIFont(descriptor: descriptor, size: size)
    }
}

/// Design tokens for the exported PDF — mirrors the app's HIG-aligned visual language
/// (system typography, 8pt spacing rhythm, coral brand accent, grouped-list cards).
private enum PDFTheme {
    // Brand
    static let accent = UIColor(hex: "#C4544A")
    static let accentSoft = UIColor(hex: "#C4544A", alpha: 0.10)
    static let accentBorder = UIColor(hex: "#C4544A", alpha: 0.25)

    // Neutrals (HIG-style semantic grays)
    static let label = UIColor(white: 0.11, alpha: 1.0)
    static let secondaryLabel = UIColor(white: 0.40, alpha: 1.0)
    static let tertiaryLabel = UIColor(white: 0.58, alpha: 1.0)
    static let separator = UIColor(white: 0.88, alpha: 1.0)
    static let cardBackground = UIColor(white: 0.98, alpha: 1.0)
    static let cardBorder = UIColor(white: 0.90, alpha: 1.0)

    // Spacing (8pt grid)
    static let margin: CGFloat = 32
    static let spacingXS: CGFloat = 4
    static let spacingS: CGFloat = 8
    static let spacingM: CGFloat = 16
    static let spacingL: CGFloat = 24
    static let spacingXL: CGFloat = 32

    // Typography — rounded design for headings/marks, standard SF for reading text.
    static let largeTitle = UIFont.rounded(ofSize: 30, weight: .bold)
    static let title2 = UIFont.rounded(ofSize: 19, weight: .bold)
    static let headline = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static let body = UIFont.systemFont(ofSize: 14.5, weight: .regular)
    static let subheadline = UIFont.systemFont(ofSize: 12.5, weight: .regular)
    static let footnote = UIFont.systemFont(ofSize: 10.5, weight: .regular)
    static let caption = UIFont.rounded(ofSize: 11, weight: .bold)

    static let cardCornerRadius: CGFloat = 20
    static let heroCornerRadius: CGFloat = 22
    static let smallCornerRadius: CGFloat = 10
}

struct ShareRecipeUtil {
    static let shared = ShareRecipeUtil()

    func shareRecipeAsPDF(
        recipe: RecipeModel,
        onSuccess: () -> Void,
        onError: (String) -> Void
    ) async {
        let image = await downloadImage(from: recipe.image)

        if let pdfURL = createRecipePDF(recipe: recipe, image: image) {
            DispatchQueue.main.async {
                sharePDF(url: pdfURL)
            }
            onSuccess()
        } else {
            os.Logger().debug("Failed to create PDF")
            onError("Failed to create PDF")
        }
    }

    /// Fetches the recipe hero image. Failures are logged and treated as
    /// "no image" so the PDF still renders a clean layout without it.
    func downloadImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            os.Logger().debug("Image download failed: \(error)")
            return nil
        }
    }

    func createRecipePDF(recipe: RecipeModel, image: UIImage?) -> URL? {
        let pageWidth: CGFloat = 595.2   // A4 @ 72dpi
        let pageHeight: CGFloat = 841.8
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

        let metadata: [String: Any] = [
            kCGPDFContextCreator as String: "RecipeApp",
            kCGPDFContextAuthor as String: recipe.chef?.name ?? "Awesome Chef!",
            kCGPDFContextTitle as String: recipe.name
        ]

        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = metadata

        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        let tempDir = FileManager.default.temporaryDirectory
        let safeName = recipe.name
            .replacingOccurrences(of: " ", with: "_")
            .components(separatedBy: CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "_-")).inverted)
            .joined()
        let pdfURL = tempDir.appendingPathComponent("\(safeName.isEmpty ? "Recipe" : safeName).pdf")

        do {
            try renderer.writePDF(to: pdfURL) { context in
                var page = PDFPageState()
                context.beginPage()
                drawRecipePDF(recipe: recipe, image: image, context: context, pageRect: pageRect, page: &page)
                drawFooter(context: context, pageRect: pageRect, page: page)
            }
            return pdfURL
        } catch {
            os.Logger().debug("Could not create PDF: \(error)")
            return nil
        }
    }

    // MARK: - Page state

    /// Tracks cursor position and page number as content flows across pages.
    private struct PDFPageState {
        var yOffset: CGFloat = PDFTheme.margin
        var pageNumber: Int = 1
    }

    // MARK: - Layout

    private func drawRecipePDF(
        recipe: RecipeModel,
        image: UIImage?,
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect,
        page: inout PDFPageState
    ) {
        drawAppHeader(context: context, pageRect: pageRect, page: &page)
        drawRecipeImage(image, context: context, pageRect: pageRect, page: &page)
        drawRecipeTitle(recipe.name, pageRect: pageRect, page: &page)
        drawDescription(recipe.description, pageRect: pageRect, page: &page)

        if let chef = recipe.chef {
            drawChefCard(chef, context: context, pageRect: pageRect, page: &page)
        }

        drawIngredients(recipe.ingredients, context: context, pageRect: pageRect, page: &page)
        drawInstructions(recipe.inststuctionsList, context: context, pageRect: pageRect, page: &page)
    }

    // MARK: - Text primitives

    @discardableResult
    private func drawText(
        _ text: String,
        font: UIFont,
        color: UIColor = PDFTheme.label,
        x: CGFloat,
        y: inout CGFloat,
        width: CGFloat,
        spacing: CGFloat = PDFTheme.spacingS,
        lineSpacing: CGFloat = 3
    ) -> CGFloat {
        let height = measuredHeight(text, font: font, width: width, lineSpacing: lineSpacing)
        drawText(text, font: font, color: color, rect: CGRect(x: x, y: y, width: width, height: height), lineSpacing: lineSpacing)
        y += height + spacing
        return height
    }

    private func drawText(
        _ text: String,
        font: UIFont,
        color: UIColor,
        rect: CGRect,
        lineSpacing: CGFloat = 3
    ) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        let attrString = NSAttributedString(string: text, attributes: [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ])
        attrString.draw(in: rect)
    }

    private func measuredHeight(_ text: String, font: UIFont, width: CGFloat, lineSpacing: CGFloat = 3) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        let attrString = NSAttributedString(string: text, attributes: [
            .font: font,
            .paragraphStyle: paragraphStyle
        ])
        let rect = attrString.boundingRect(
            with: CGSize(width: width, height: .infinity),
            options: [.usesLineFragmentOrigin],
            context: nil
        )
        return rect.height.rounded(.up)
    }

    /// Reserves footer space and, if the next block won't fit, closes out the
    /// current page's footer and starts a fresh one with a running header.
    private func startNewPageIfNeeded(
        neededSpace: CGFloat,
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect,
        page: inout PDFPageState
    ) {
        let footerReserve: CGFloat = 48
        if page.yOffset + neededSpace > pageRect.height - footerReserve {
            drawFooter(context: context, pageRect: pageRect, page: page)
            context.beginPage()
            page.pageNumber += 1
            page.yOffset = PDFTheme.margin
            drawRunningHeader(context: context, pageRect: pageRect, page: &page)
        }
    }

    // MARK: - Header / footer

    private func drawAppHeader(
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect,
        page: inout PDFPageState
    ) {
        let margin = PDFTheme.margin
        let badgeSize: CGFloat = 32

        let badgeRect = CGRect(x: margin, y: page.yOffset, width: badgeSize, height: badgeSize)
        let badgePath = UIBezierPath(roundedRect: badgeRect, cornerRadius: PDFTheme.smallCornerRadius)
        PDFTheme.accent.setFill()
        badgePath.fill()

        if let icon = UIImage(named: "AppIcon") {
            let inset = badgeRect.insetBy(dx: 5, dy: 5)
            let path = UIBezierPath(roundedRect: inset, cornerRadius: 6)
            context.cgContext.saveGState()
            path.addClip()
            icon.draw(in: inset)
            context.cgContext.restoreGState()
        } else {
            let mark = "🍽️"
            let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15)]
            let size = (mark as NSString).size(withAttributes: attrs)
            let point = CGPoint(x: badgeRect.midX - size.width / 2, y: badgeRect.midY - size.height / 2)
            (mark as NSString).draw(at: point, withAttributes: attrs)
        }

        let textX = margin + badgeSize + PDFTheme.spacingS
        let labelHeight = measuredHeight("RecipeApp", font: PDFTheme.headline, width: pageRect.width, lineSpacing: 0)
        drawText("RecipeApp", font: .rounded(ofSize: 15, weight: .semibold), color: PDFTheme.label,
                  rect: CGRect(x: textX, y: page.yOffset + 1, width: pageRect.width - textX - margin, height: labelHeight))
        drawText("Recipe card", font: PDFTheme.footnote, color: PDFTheme.tertiaryLabel,
                  rect: CGRect(x: textX, y: page.yOffset + 1 + labelHeight + 1, width: pageRect.width - textX - margin, height: 14))

        page.yOffset += badgeSize + PDFTheme.spacingL
    }

    /// Compact repeated header shown at the top of overflow pages.
    private func drawRunningHeader(
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect,
        page: inout PDFPageState
    ) {
        let margin = PDFTheme.margin
        var y = page.yOffset
        drawText("RecipeApp", font: PDFTheme.subheadline, color: PDFTheme.tertiaryLabel,
                  x: margin, y: &y, width: pageRect.width - 2 * margin, spacing: PDFTheme.spacingS)
        drawHairline(context: context, y: y, x1: margin, x2: pageRect.width - margin, color: PDFTheme.separator)
        page.yOffset = y + PDFTheme.spacingL
    }

    private func drawFooter(
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect,
        page: PDFPageState
    ) {
        let margin = PDFTheme.margin
        let footerY = pageRect.height - 36

        context.cgContext.saveGState()
        drawHairline(context: context, y: footerY, x1: margin, x2: pageRect.width - margin, color: PDFTheme.separator)

        let attrs: [NSAttributedString.Key: Any] = [
            .font: PDFTheme.footnote,
            .foregroundColor: PDFTheme.tertiaryLabel
        ]
        ("Made with RecipeApp" as NSString).draw(
            at: CGPoint(x: margin, y: footerY + PDFTheme.spacingS),
            withAttributes: attrs
        )

        let pageLabel = "Page \(page.pageNumber)" as NSString
        let size = pageLabel.size(withAttributes: attrs)
        pageLabel.draw(
            at: CGPoint(x: pageRect.width - margin - size.width, y: footerY + PDFTheme.spacingS),
            withAttributes: attrs
        )
        context.cgContext.restoreGState()
    }

    private func drawHairline(context: UIGraphicsPDFRendererContext, y: CGFloat, x1: CGFloat, x2: CGFloat, color: UIColor) {
        context.cgContext.saveGState()
        context.cgContext.setStrokeColor(color.cgColor)
        context.cgContext.setLineWidth(0.75)
        context.cgContext.move(to: CGPoint(x: x1, y: y))
        context.cgContext.addLine(to: CGPoint(x: x2, y: y))
        context.cgContext.strokePath()
        context.cgContext.restoreGState()
    }

    // MARK: - Hero image

    /// Full-bleed, edge-to-edge (within the content margins) hero image using an
    /// aspect-fill crop — the same treatment Apple News / App Store use for
    /// feature artwork, rather than letterboxing the photo inside empty space.
    private func drawRecipeImage(
        _ image: UIImage?,
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect,
        page: inout PDFPageState
    ) {
        guard let image = image, image.size.width > 0, image.size.height > 0 else { return }

        let margin = PDFTheme.margin
        let targetWidth = pageRect.width - 2 * margin
        let targetHeight: CGFloat = 220

        startNewPageIfNeeded(neededSpace: targetHeight + PDFTheme.spacingL, context: context, pageRect: pageRect, page: &page)

        let targetRect = CGRect(x: margin, y: page.yOffset, width: targetWidth, height: targetHeight)

        // Soft elevation behind the image, iOS-card style.
        context.cgContext.saveGState()
        context.cgContext.setShadow(offset: CGSize(width: 0, height: 6), blur: 14, color: UIColor.black.withAlphaComponent(0.20).cgColor)
        UIColor.white.setFill()
        UIBezierPath(roundedRect: targetRect, cornerRadius: PDFTheme.heroCornerRadius).fill()
        context.cgContext.restoreGState()

        context.cgContext.saveGState()
        UIBezierPath(roundedRect: targetRect, cornerRadius: PDFTheme.heroCornerRadius).addClip()

        let imageAspect = image.size.width / image.size.height
        let targetAspect = targetRect.width / targetRect.height
        var drawRect = targetRect
        if imageAspect > targetAspect {
            // Image is relatively wider than the frame — match height, crop the sides.
            let scaledWidth = targetRect.height * imageAspect
            drawRect = CGRect(x: targetRect.midX - scaledWidth / 2, y: targetRect.minY, width: scaledWidth, height: targetRect.height)
        } else {
            // Image is relatively taller — match width, crop top/bottom.
            let scaledHeight = targetRect.width / imageAspect
            drawRect = CGRect(x: targetRect.minX, y: targetRect.midY - scaledHeight / 2, width: targetRect.width, height: scaledHeight)
        }
        image.draw(in: drawRect)

        // Subtle bottom scrim so the card edge reads cleanly against busy photos.
        if let gradient = CGGradient(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.withAlphaComponent(0.16).cgColor] as CFArray,
            locations: [0, 1]
        ) {
            context.cgContext.drawLinearGradient(
                gradient,
                start: CGPoint(x: targetRect.midX, y: targetRect.maxY - 56),
                end: CGPoint(x: targetRect.midX, y: targetRect.maxY),
                options: []
            )
        }
        context.cgContext.restoreGState()

        // Hairline rim to keep the card crisp on light backgrounds.
        context.cgContext.saveGState()
        PDFTheme.cardBorder.setStroke()
        let rim = UIBezierPath(roundedRect: targetRect, cornerRadius: PDFTheme.heroCornerRadius)
        rim.lineWidth = 0.75
        rim.stroke()
        context.cgContext.restoreGState()

        page.yOffset += targetHeight + PDFTheme.spacingL
    }

    // MARK: - Title / description

    private func drawRecipeTitle(_ title: String, pageRect: CGRect, page: inout PDFPageState) {
        let margin = PDFTheme.margin
        drawText(
            title,
            font: PDFTheme.largeTitle,
            color: PDFTheme.label,
            x: margin,
            y: &page.yOffset,
            width: pageRect.width - 2 * margin,
            spacing: PDFTheme.spacingM,
            lineSpacing: 2
        )
    }

    private func drawDescription(_ description: String, pageRect: CGRect, page: inout PDFPageState) {
        guard !description.isEmpty else { return }
        let margin = PDFTheme.margin
        drawText(
            description,
            font: PDFTheme.body,
            color: PDFTheme.secondaryLabel,
            x: margin,
            y: &page.yOffset,
            width: pageRect.width - 2 * margin,
            spacing: PDFTheme.spacingXL,
            lineSpacing: 4
        )
    }

    // MARK: - Chef card

    private func drawChefCard(
        _ chef: UserModel,
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect,
        page: inout PDFPageState
    ) {
        let margin = PDFTheme.margin
        let cardWidth = pageRect.width - 2 * margin
        let avatarSize: CGFloat = 44
        let padding: CGFloat = PDFTheme.spacingM

        var lines = 1
        if chef.phone != nil { lines += 1 }
        let cardHeight = padding * 2 + max(avatarSize, CGFloat(lines) * 16 + 18)

        startNewPageIfNeeded(neededSpace: cardHeight + PDFTheme.spacingL, context: context, pageRect: pageRect, page: &page)

        let cardRect = CGRect(x: margin, y: page.yOffset, width: cardWidth, height: cardHeight)
        drawGroupedCardBackground(cardRect, context: context)

        // Coral avatar with the chef's initials.
        let avatarRect = CGRect(x: cardRect.minX + padding, y: cardRect.midY - avatarSize / 2, width: avatarSize, height: avatarSize)
        PDFTheme.accent.setFill()
        UIBezierPath(ovalIn: avatarRect).fill()

        let initials = initials(from: chef.name)
        let initialsAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.rounded(ofSize: 15, weight: .semibold),
            .foregroundColor: UIColor.white
        ]
        let initialsSize = (initials as NSString).size(withAttributes: initialsAttrs)
        (initials as NSString).draw(
            at: CGPoint(x: avatarRect.midX - initialsSize.width / 2, y: avatarRect.midY - initialsSize.height / 2),
            withAttributes: initialsAttrs
        )

        var textY = cardRect.minY + padding - 2
        let textX = avatarRect.maxX + PDFTheme.spacingM
        let textWidth = cardRect.maxX - padding - textX - 70 // leave room for the rating badge

        drawText("Chef \(chef.name)", font: PDFTheme.headline, color: PDFTheme.label,
                  x: textX, y: &textY, width: textWidth, spacing: PDFTheme.spacingXS)

        var contactLine = chef.email
        if let phone = chef.phone {
            contactLine += "  ·  \(phone)"
        }
        drawText(contactLine, font: PDFTheme.subheadline, color: PDFTheme.secondaryLabel,
                  x: textX, y: &textY, width: textWidth, spacing: 0)

        // Rating badge, top-right of the card.
        if let rate = chef.rate {
            let badgeText = "★ \(rate.ratingFormatted)"
            let badgeAttrs: [NSAttributedString.Key: Any] = [.font: PDFTheme.caption, .foregroundColor: PDFTheme.accent]
            let badgeTextSize = (badgeText as NSString).size(withAttributes: badgeAttrs)
            let badgeRect = CGRect(
                x: cardRect.maxX - padding - badgeTextSize.width - 16,
                y: cardRect.minY + padding - 4,
                width: badgeTextSize.width + 16,
                height: badgeTextSize.height + 8
            )
            let badgePath = UIBezierPath(roundedRect: badgeRect, cornerRadius: badgeRect.height / 2)
            PDFTheme.accentSoft.setFill()
            badgePath.fill()
            PDFTheme.accentBorder.setStroke()
            badgePath.lineWidth = 0.75
            badgePath.stroke()
            (badgeText as NSString).draw(
                at: CGPoint(x: badgeRect.minX + 8, y: badgeRect.minY + 4),
                withAttributes: badgeAttrs
            )
        }

        page.yOffset += cardHeight + PDFTheme.spacingXL
    }

    private func initials(from name: String) -> String {
        let parts = name.split(separator: " ")
        let chars = parts.prefix(2).compactMap { $0.first }
        return chars.isEmpty ? "?" : String(chars).uppercased()
    }

    // MARK: - Shared card chrome

    /// Native iOS "grouped list" card: soft off-white fill, hairline border,
    /// faint elevation — matches Settings / Reminders section backgrounds.
    private func drawGroupedCardBackground(_ rect: CGRect, context: UIGraphicsPDFRendererContext) {
        context.cgContext.saveGState()
        context.cgContext.setShadow(offset: CGSize(width: 0, height: 2), blur: 6, color: UIColor.black.withAlphaComponent(0.06).cgColor)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: PDFTheme.cardCornerRadius)
        PDFTheme.cardBackground.setFill()
        path.fill()
        context.cgContext.restoreGState()

        context.cgContext.saveGState()
        PDFTheme.cardBorder.setStroke()
        let stroke = UIBezierPath(roundedRect: rect, cornerRadius: PDFTheme.cardCornerRadius)
        stroke.lineWidth = 0.75
        stroke.stroke()
        context.cgContext.restoreGState()
    }

    private func drawSectionHeading(_ text: String, emoji: String, pageRect: CGRect, page: inout PDFPageState) {
        let margin = PDFTheme.margin
        drawText(
            "\(emoji)  \(text)",
            font: PDFTheme.title2,
            color: PDFTheme.label,
            x: margin,
            y: &page.yOffset,
            width: pageRect.width - 2 * margin,
            spacing: PDFTheme.spacingM
        )
    }

    // MARK: - Ingredients (single-column grouped list — fixes prior overlap)

    /// Ingredient quantities vary wildly in length ("to taste" vs. a full
    /// clause). A two-column, fixed-width row can't guarantee both the name
    /// and quantity fit without colliding, so each ingredient is now its own
    /// list row: name on one line, quantity wrapped beneath it in secondary
    /// gray — the same pattern as a Reminders row with notes.
    private func drawIngredients(
        _ ingredients: [IngredientModel],
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect,
        page: inout PDFPageState
    ) {
        guard !ingredients.isEmpty else { return }
        let margin = PDFTheme.margin
        let cardWidth = pageRect.width - 2 * margin

        drawSectionHeading("Ingredients", emoji: "🧄", pageRect: pageRect, page: &page)

        let rowPaddingH: CGFloat = PDFTheme.spacingM
        let rowPaddingV: CGFloat = 12
        let markerDiameter: CGFloat = 16
        let indent = rowPaddingH + markerDiameter + PDFTheme.spacingS
        let textWidth = cardWidth - indent - rowPaddingH

        // Pre-measure every row so the card is drawn with its final height
        // up front, and so pagination can split cleanly between rows.
        let rows: [(ingredient: IngredientModel, nameHeight: CGFloat, qtyHeight: CGFloat)] = ingredients.map { ingredient in
            let nameH = measuredHeight(ingredient.name, font: PDFTheme.headline, width: textWidth, lineSpacing: 2)
            let qtyH = measuredHeight(ingredient.quantity, font: PDFTheme.subheadline, width: textWidth, lineSpacing: 2)
            return (ingredient, nameH, qtyH)
        }

        var index = 0
        while index < rows.count {
            // Fill remaining space on the current page with as many rows as fit,
            // opening a new card on the next page for the rest.
            var cardHeight: CGFloat = rowPaddingV
            var rowsInCard = 0
            var cursor = index

            while cursor < rows.count {
                let row = rows[cursor]
                let rowHeight = max(markerDiameter, row.nameHeight + 2 + row.qtyHeight) + rowPaddingV
                let available = pageRect.height - 48 - page.yOffset - PDFTheme.spacingM
                if cardHeight + rowHeight > max(available, rowHeight), rowsInCard > 0 {
                    break
                }
                cardHeight += rowHeight
                rowsInCard += 1
                cursor += 1
            }

            if rowsInCard == 0 {
                // A single row is taller than a fresh page's usable height — draw
                // it anyway to avoid an infinite loop; extremely long text will
                // simply run under the footer in this rare edge case.
                rowsInCard = 1
                cardHeight += max(markerDiameter, rows[index].nameHeight + 2 + rows[index].qtyHeight)
                cursor = index + 1
            }

            startNewPageIfNeeded(neededSpace: cardHeight, context: context, pageRect: pageRect, page: &page)

            let cardRect = CGRect(x: margin, y: page.yOffset, width: cardWidth, height: cardHeight)
            drawGroupedCardBackground(cardRect, context: context)

            var rowY = cardRect.minY + rowPaddingV / 2
            for rowIndex in index..<cursor {
                let row = rows[rowIndex]
                let rowHeight = max(markerDiameter, row.nameHeight + 2 + row.qtyHeight) + rowPaddingV
                let contentTop = rowY + rowPaddingV / 2

                // Outline "checklist" dot, vertically centered on the name line.
                let markerRect = CGRect(x: cardRect.minX + rowPaddingH, y: contentTop + (row.nameHeight - markerDiameter) / 2, width: markerDiameter, height: markerDiameter)
                context.cgContext.saveGState()
                PDFTheme.accent.setStroke()
                let marker = UIBezierPath(ovalIn: markerRect)
                marker.lineWidth = 1.5
                marker.stroke()
                context.cgContext.restoreGState()

                let textX = cardRect.minX + indent
                var textY = contentTop
                drawText(row.ingredient.name, font: PDFTheme.headline, color: PDFTheme.label,
                          x: textX, y: &textY, width: textWidth, spacing: 2, lineSpacing: 2)
                drawText(row.ingredient.quantity, font: PDFTheme.subheadline, color: PDFTheme.tertiaryLabel,
                          x: textX, y: &textY, width: textWidth, spacing: 0, lineSpacing: 2)

                if rowIndex < cursor - 1 {
                    drawHairline(context: context, y: rowY + rowHeight, x1: textX, x2: cardRect.maxX - rowPaddingH, color: PDFTheme.separator)
                }
                rowY += rowHeight
            }

            page.yOffset += cardHeight + (cursor < rows.count ? PDFTheme.spacingL : PDFTheme.spacingXL)
            index = cursor
        }
    }

    // MARK: - Instructions

    private func drawInstructions(
        _ instructions: [String],
        context: UIGraphicsPDFRendererContext,
        pageRect: CGRect,
        page: inout PDFPageState
    ) {
        guard !instructions.isEmpty else { return }
        let margin = PDFTheme.margin

        drawSectionHeading("Instructions", emoji: "📋", pageRect: pageRect, page: &page)

        let stepIndent: CGFloat = 32

        for (index, step) in instructions.enumerated() {
            let textWidth = pageRect.width - 2 * margin - stepIndent
            let textHeight = measuredHeight(step, font: PDFTheme.body, width: textWidth, lineSpacing: 4)
            let badgeDiameter: CGFloat = 24
            let blockHeight = max(badgeDiameter, textHeight) + PDFTheme.spacingM

            startNewPageIfNeeded(neededSpace: blockHeight, context: context, pageRect: pageRect, page: &page)

            // Coral numbered badge.
            let badgeRect = CGRect(x: margin, y: page.yOffset, width: badgeDiameter, height: badgeDiameter)
            PDFTheme.accent.setFill()
            UIBezierPath(ovalIn: badgeRect).fill()

            let numberText = "\(index + 1)"
            let numberAttrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.rounded(ofSize: 12, weight: .semibold),
                .foregroundColor: UIColor.white
            ]
            let numberSize = (numberText as NSString).size(withAttributes: numberAttrs)
            (numberText as NSString).draw(
                at: CGPoint(x: badgeRect.midX - numberSize.width / 2, y: badgeRect.midY - numberSize.height / 2),
                withAttributes: numberAttrs
            )

            drawText(step, font: PDFTheme.body, color: PDFTheme.label,
                     rect: CGRect(x: margin + stepIndent, y: page.yOffset + 1, width: textWidth, height: textHeight), lineSpacing: 4)

            page.yOffset += max(badgeDiameter, textHeight) + PDFTheme.spacingM
        }

        page.yOffset += PDFTheme.spacingS
    }

    // MARK: - Sharing

    func sharePDF(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
}
