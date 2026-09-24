/*
* Created by Martin Wainaina on 24/09/2026
*
* Feel free to contribute.
*/

//
//  ContactDetailView.swift
//  Recipe
//
//  Created by RAFIKI on 24/09/2026.
//

import SwiftUI
import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContactDetailView: View {

    let name: String
    let email: String
    let imageURL: URL

    @State private var heroImage: UIImage?
    @State private var imageLoadFailed = false
    @State private var backgroundColor = Color(white: 0.16)

    // MARK: - Scroll state

    /// Raw content offset. Allowed to go negative during the top overscroll/bounce,
    /// which is what powers the pull-to-stretch zoom on the photo.
    @State private var scrollOffset: CGFloat = 0
    @State private var safeAreaTop: CGFloat = 47

    // MARK: - Layout constants

    /// Height of the photo itself.
    private let imageHeight: CGFloat = 300
    /// Extra height reserved for name / email / action buttons beneath the photo.
    private let infoHeight: CGFloat = 190
    /// Scroll distance before the photo locks in place ("sticks").
    private let imageStickDistance: CGFloat = 120
    /// Scroll range over which the large name crossfades into the compact bar title.
    private let titleCollapseStart: CGFloat = 230
    private let titleCollapseEnd: CGFloat = 290
    private let navigationBarHeight: CGFloat = 44

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                scrollContent
            }
            .scrollIndicators(.hidden)
            .coordinateSpace(name: "ContactScroll")
            .onScrollGeometryChange(
                for: CGFloat.self,
                of: { $0.contentOffset.y },
                action: { _, value in
                    scrollOffset = value
                }
            )

            compactNavigationBar
        }
        .ignoresSafeArea(edges: .top)
        .preferredColorScheme(.dark)
        .task {
            safeAreaTop = resolvedSafeAreaTop()
            await loadImage()
        }
    }
}

// MARK: - Scroll content

private extension ContactDetailView {

    var scrollContent: some View {
        VStack(spacing: 0) {
            heroPhoto
                .offset(y: stickyImageOffset)
                .zIndex(0)

            heroInfo
                .padding(.top, -64) // overlaps the bottom of the photo, like Contacts
                .zIndex(1)

            contentSheet
                .zIndex(2)
        }
    }

    /// How far the photo is allowed to stretch when the user pulls down past the top.
    var pullStretch: CGFloat { max(-scrollOffset, 0) }

    /// Displayed height of the photo, including any pull-down stretch.
    var displayedImageHeight: CGFloat { imageHeight + pullStretch }

    /// The counter-offset that "locks" the photo once the user has scrolled past
    /// `imageStickDistance`. Before the threshold this is 0 (photo scrolls normally,
    /// including the pull-down stretch case, since scrollOffset is negative there).
    /// After the threshold it grows 1:1 with further scroll, exactly cancelling it,
    /// so the photo freezes at whatever position it had reached and the rest of the
    /// content — painted after it — scrolls up and covers it.
    var stickyImageOffset: CGFloat {
        max(scrollOffset - imageStickDistance, 0)
    }

    /// Progressive darkening of the photo as content rises to cover it.
    var coverageScrim: Double {
        let progress = (scrollOffset - imageStickDistance) / 260
        return Double(min(max(progress, 0), 1)) * 0.45
    }

    /// Opacity of the large hero name/email block — fades out as it nears the nav bar.
    var largeInfoOpacity: CGFloat {
        let progress = (scrollOffset - titleCollapseStart) / (titleCollapseEnd - titleCollapseStart)
        return 1 - min(max(progress, 0), 1)
    }

    /// Opacity of the compact nav bar title — the mirror image of the above.
    var compactTitleOpacity: CGFloat {
        let progress = (scrollOffset - titleCollapseStart) / (titleCollapseEnd - titleCollapseStart)
        return min(max(progress, 0), 1)
    }

    /// Discrete state for the nav bar material/divider, so they can be given a short,
    /// deliberate animation instead of jittering every scroll frame.
    var isCompact: Bool { scrollOffset > titleCollapseStart }
}

// MARK: - Hero photo

private extension ContactDetailView {

    var heroPhoto: some View {
        ZStack(alignment: .bottom) {
            photoImage
                .frame(height: displayedImageHeight)
                .clipped()

            LinearGradient(
                colors: [
                    .clear,
                    .black.opacity(0.05),
                    .black.opacity(0.55),
                    .black.opacity(0.92)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            Color.black.opacity(coverageScrim)
        }
        .frame(height: displayedImageHeight)
    }

    var photoImage: some View {
        Group {
            if let heroImage {
                Image(uiImage: heroImage)
                    .resizable()
                    .scaledToFill()
            } else {
                backgroundColor
                    .overlay {
                        if !imageLoadFailed {
                            ProgressView().tint(.white)
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Hero info (name, email, actions)

private extension ContactDetailView {

    var heroInfo: some View {
        VStack(spacing: 18) {
            Text(name)
                .font(.system(size: 40, weight: .bold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.72)
                .shadow(color: .black.opacity(0.3), radius: 10, y: 4)

            Text(email)
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(.white.opacity(0.88))
                .lineLimit(1)
                .minimumScaleFactor(0.75)

            actionButtons
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 32)
        .frame(maxWidth: .infinity)
        .opacity(largeInfoOpacity)
        .scaleEffect(1 - (1 - largeInfoOpacity) * 0.08, anchor: .bottom)
    }

    var actionButtons: some View {
        HStack(spacing: 16) {
            contactAction(systemImage: "message.fill", accessibilityLabel: "Message") {
                print("Message")
            }
            contactAction(systemImage: "phone.fill", accessibilityLabel: "Call") {
                print("Call")
            }
            contactAction(systemImage: "video.fill", accessibilityLabel: "Video call") {
                print("Video")
            }
            contactAction(systemImage: "envelope.fill", accessibilityLabel: "Email") {
                print("Email")
            }
        }
    }

    func contactAction(
        systemImage: String,
        accessibilityLabel: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 19, weight: .medium))
                .foregroundStyle(.white)
                .frame(width: 58, height: 58)
                .background {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .overlay { Circle().fill(.white.opacity(0.06)) }
                }
                .overlay {
                    Circle().stroke(.white.opacity(0.18), lineWidth: 0.75)
                }
                .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(accessibilityLabel)
    }
}

// MARK: - Compact navigation bar

private extension ContactDetailView {

    var compactNavigationBar: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                backButton

                Text(name)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
                    .opacity(compactTitleOpacity)

                editButton
            }
            .padding(.horizontal, 16)
            .frame(height: navigationBarHeight)
            .padding(.top, safeAreaTop)

            Rectangle()
                .fill(.white.opacity(0.08))
                .frame(height: 0.5)
                .opacity(isCompact ? 1 : 0)
        }
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(isCompact ? 1 : 0)
                .ignoresSafeArea(edges: .top)
        }
        .animation(.easeOut(duration: 0.2), value: isCompact)
    }

    var backButton: some View {
        Button {
            print("Back")
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 36, height: 36)
                .background { Circle().fill(.ultraThinMaterial) }
                .overlay { Circle().stroke(.white.opacity(0.16), lineWidth: 0.75) }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Back")
    }

    var editButton: some View {
        Button("Edit") {
            print("Edit")
        }
        .font(.system(size: 17, weight: .medium))
        .foregroundStyle(.white)
        .frame(width: 48, height: 36)
        .buttonStyle(.plain)
    }
}

// MARK: - Content sheet (rises up and covers the photo as you scroll)

private extension ContactDetailView {

    var contentSheet: some View {
        contactContent
            .padding(.horizontal, 16)
            .padding(.top, 20)
            .padding(.bottom, 48)
            .frame(maxWidth: .infinity)
            .background {
                UnevenRoundedRectangle(
                    topLeadingRadius: 28,
                    topTrailingRadius: 28
                )
                .fill(cardColor)
                .ignoresSafeArea(edges: .bottom)
            }
    }

    var contactContent: some View {
        VStack(spacing: 14) {
            sharedNameCard
            addressCard
            notesCard
            shareContactButton
        }
    }

    var sharedNameCard: some View {
        contactCard {
            HStack(spacing: 16) {
                Group {
                    if let heroImage {
                        Image(uiImage: heroImage)
                            .resizable()
                            .scaledToFill()
                    } else {
                        backgroundColor.opacity(0.6)
                    }
                }
                .frame(width: 64, height: 64)
                .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text("Shared Name and Photo")
                        .font(.system(size: 20, weight: .medium))
                    Text("Contacts Only")
                        .font(.system(size: 16))
                        .foregroundStyle(.white.opacity(0.55))
                }
                .foregroundStyle(.white)

                Spacer(minLength: 8)

                Image(systemName: "chevron.right")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.55))
            }
        }
    }

    var addressCard: some View {
        contactCard {
            VStack(alignment: .leading, spacing: 20) {
                addressSection(title: "Work", address: ["Mara Road", "Nairobi", "Kenya"])
                Divider().overlay(.white.opacity(0.12))
                addressSection(title: "Home", address: ["Kamiti Road", "Nairobi", "Kenya"])
            }
        }
    }

    func addressSection(title: String, address: [String]) -> some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white.opacity(0.55))
                ForEach(address, id: \.self) { line in
                    Text(line)
                        .font(.system(size: 19))
                        .foregroundStyle(.white)
                }
            }
            Spacer()
            Image(systemName: "mappin.and.ellipse")
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(.white.opacity(0.8))
                .padding(.top, 24)
        }
    }

    var notesCard: some View {
        contactCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("Notes")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white)
                Text("No notes")
                    .font(.system(size: 16))
                    .foregroundStyle(.white.opacity(0.45))
                Spacer(minLength: 70)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    var shareContactButton: some View {
        Button {
            print("Share contact")
        } label: {
            HStack {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 18, weight: .medium))
                Text("Share Contact")
                    .font(.system(size: 18, weight: .medium))
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.45))
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 24)
            .frame(height: 64)
            .background {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(cardColor)
            }
        }
        .buttonStyle(.plain)
    }

    func contactCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .padding(24)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(cardColor)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .stroke(.white.opacity(0.06), lineWidth: 0.75)
            }
    }

    var cardColor: Color {
        backgroundColor.mix(with: .black, by: 0.28)
    }
}

// MARK: - Image loading & dominant color

private extension ContactDetailView {

    /// Fetches the photo exactly once and derives both the displayed image and the
    /// background tint from that single decode — no duplicate network calls, no
    /// mismatched load timing between the hero, the background and the avatar.
    func loadImage() async {
        do {
            let (data, _) = try await URLSession.shared.data(from: imageURL)
            guard let image = UIImage(data: data) else {
                await MainActor.run { imageLoadFailed = true }
                return
            }
            let dominant = await ImageColorExtractor().extractColor(from: image)
            await MainActor.run {
                heroImage = image
                if let dominant {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        backgroundColor = Color(dominant)
                    }
                }
            }
        } catch {
            await MainActor.run { imageLoadFailed = true }
        }
    }

    func resolvedSafeAreaTop() -> CGFloat {
        UIApplication.shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?
            .safeAreaInsets
            .top ?? 47
    }
}

// MARK: - Color helpers

extension Color {
    func mix(with color: Color, by amount: CGFloat) -> Color {
        let amount = min(max(amount, 0), 1)
        let uiColor1 = UIColor(self)
        let uiColor2 = UIColor(color)

        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0

        uiColor1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        uiColor2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        return Color(
            red: r1 + (r2 - r1) * amount,
            green: g1 + (g2 - g1) * amount,
            blue: b1 + (b2 - b1) * amount
        )
    }
}

// MARK: - Dominant color extraction

actor ImageColorExtractor {
    private let context = CIContext()

    func extractColor(from image: UIImage) -> UIColor? {
        guard let cgImage = image.cgImage else { return nil }

        let ciImage = CIImage(cgImage: cgImage)
        let filter = CIFilter.areaAverage()
        filter.inputImage = ciImage
        filter.extent = ciImage.extent

        guard
            let outputImage = filter.outputImage,
            let bitmap = context.createCGImage(
                outputImage,
                from: CGRect(x: 0, y: 0, width: 1, height: 1)
            ),
            let dataProvider = bitmap.dataProvider?.data,
            let pointer = CFDataGetBytePtr(dataProvider)
        else {
            return nil
        }

        return UIColor(
            red: CGFloat(pointer[0]) / 255,
            green: CGFloat(pointer[1]) / 255,
            blue: CGFloat(pointer[2]) / 255,
            alpha: 1
        )
    }
}

// MARK: - Preview

#Preview {
    if let url = URL(
        string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDc425L193k7Fvr3k2OBsTJTZL4tFjsGKNOq_4ByyjYmHlhRq50cisgW0&s=10"
    ) {
        ContactDetailView(
            name: "Steve Jobs",
            email: "steve@apple.com",
            imageURL: url
        )
    }
}
