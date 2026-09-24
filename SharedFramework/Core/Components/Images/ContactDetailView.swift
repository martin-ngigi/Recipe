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

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContactDetailView: View {

    let name: String
    let email: String
    let imageURL: URL

    @State private var backgroundColor = Color.gray
    @State private var scrollOffset: CGFloat = 0

    private let heroHeight: CGFloat = 620

    var body: some View {
        ZStack {
            background
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    hero

                    contactContent
                        .padding(.horizontal, 16)
                        .padding(.bottom, 40)
                }
            }
            .coordinateSpace(name: "CONTACT_SCROLL")
            .scrollIndicators(.hidden)
            .onScrollGeometryChange(
                for: CGFloat.self,
                of: { geometry in
                    max(0, -geometry.contentOffset.y)
                },
                action: { _, value in
                    scrollOffset = value
                }
            )

            topBar
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Background

private extension ContactDetailView {

    var background: some View {
        ZStack {
            backgroundColor

            LinearGradient(
                colors: [
                    .black.opacity(0.05),
                    .black.opacity(0.15),
                    .black.opacity(0.35)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .animation(.easeInOut(duration: 0.4), value: backgroundColor)
    }
}

// MARK: - Hero

private extension ContactDetailView {

    var hero: some View {
        GeometryReader { proxy in

            let minY = proxy.frame(in: .named("CONTACT_SCROLL")).minY

            let stretch = max(0, minY)
            let collapse = min(max(0, -minY), 280)

            let imageHeight = heroHeight + stretch - collapse * 0.45

            let blur = min(collapse / 35, 8)
            let imageOpacity = max(0.55, 1 - collapse / 700)

            ZStack(alignment: .bottom) {

                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: proxy.size.width,
                                height: imageHeight
                            )
                            .clipped()
                            .blur(radius: blur)
                            .opacity(imageOpacity)
                            .overlay {
                                LinearGradient(
                                    colors: [
                                        .clear,
                                        .black.opacity(0.05),
                                        .black.opacity(0.65)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            }

                    case .failure:
                        Color.gray

                    default:
                        Color.gray.opacity(0.3)
                            .overlay {
                                ProgressView()
                                    .tint(.white)
                            }
                    }
                }

                VStack(spacing: 24) {

                    Text(name)
                        .font(.system(size: 46, weight: .bold))
                        .foregroundStyle(.white)
                        .minimumScaleFactor(0.7)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .shadow(
                            color: .black.opacity(0.35),
                            radius: 8,
                            y: 3
                        )
                        .opacity(
                            max(0, 1 - scrollOffset / 260)
                        )
                        .scaleEffect(
                            1 - min(scrollOffset / 1200, 0.18)
                        )
                    
                    Text(email)
                        .font(.system(size: 46, weight: .bold))
                        .foregroundStyle(.white)
                        .minimumScaleFactor(0.7)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .shadow(
                            color: .black.opacity(0.35),
                            radius: 8,
                            y: 3
                        )
                        .scaleEffect(
                            1 - min(collapse / 1200, 0.18)
                        )
                        .opacity(
                            max(0.65, 1 - collapse / 600)
                        )
                    

                    actionButtons
                        .opacity(
                            max(0, 1 - collapse / 260)
                        )
                        .scaleEffect(
                            1 - min(collapse / 900, 0.15)
                        )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
            .frame(
                width: proxy.size.width,
                height: imageHeight
            )
            .offset(y: minY < 0 ? minY * 0.15 : 0)
            .clipped()
        }
        .frame(height: heroHeight)
    }
}

// MARK: - Actions

private extension ContactDetailView {

    var actionButtons: some View {
        HStack(spacing: 18) {
            contactAction(
                systemImage: "message.fill"
            ) {
                print("Message")
            }

            contactAction(
                systemImage: "phone.fill"
            ) {
                print("Call")
            }

            contactAction(
                systemImage: "video.fill"
            ) {
                print("Video")
            }

            contactAction(
                systemImage: "envelope.fill"
            ) {
                print("Email")
            }
        }
    }

    func contactAction(
        systemImage: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 25, weight: .medium))
                .foregroundStyle(.white.opacity(0.75))
                .frame(width: 90, height: 90)
                .background {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .opacity(0.35)
                }
                .overlay {
                    Circle()
                        .stroke(
                            .white.opacity(0.25),
                            lineWidth: 1
                        )
                }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Content

private extension ContactDetailView {

    var contactContent: some View {
        VStack(spacing: 14) {

            sharedNameCard

            addressCard

            notesCard

            shareContactButton
        }
        .padding(.top, 12)
    }

    var sharedNameCard: some View {
        contactCard {
            HStack(spacing: 16) {

                AsyncImage(url: imageURL) { phase in
                    if case .success(let image) = phase {
                        image
                            .resizable()
                            .scaledToFill()
                    } else {
                        Color.white.opacity(0.15)
                    }
                }
                .frame(width: 64, height: 64)
                .clipShape(Circle())

                VStack(alignment: .leading, spacing: 2) {
                    Text("Shared Name and Photo")
                    Text("Contacts Only")
                }
                .font(.system(size: 22))
                .foregroundStyle(.white)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white)
            }
        }
    }

    var addressCard: some View {
        contactCard {

            VStack(alignment: .leading, spacing: 20) {

                addressSection(
                    title: "work",
                    address: [
                        "Mara Road",
                        "Nairobi",
                        "Kenya"
                    ]
                )

                Divider()
                    .overlay(.white.opacity(0.15))

                addressSection(
                    title: "home",
                    address: [
                        "Kamiti Road",
                        "Nairobi",
                        "Kenya"
                    ]
                )
            }
        }
    }

    func addressSection(
        title: String,
        address: [String]
    ) -> some View {
        HStack(alignment: .top, spacing: 16) {

            VStack(alignment: .leading, spacing: 2) {

                Text(title)
                    .font(.system(size: 18))

                ForEach(address, id: \.self) { line in
                    Text(line)
                        .font(.system(size: 22))
                }
            }
            .foregroundStyle(.white)

            Spacer()

            Image(systemName: "mappin.and.ellipse")
                .font(.system(size: 24))
                .foregroundStyle(.white)
                .padding(.top, 35)
        }
    }

    var notesCard: some View {
        contactCard {
            VStack(alignment: .leading) {
                Text("Notes")
                    .font(.system(size: 21))
                    .foregroundStyle(.white)

                Spacer(minLength: 100)
            }
        }
    }

    var shareContactButton: some View {
        Button {
            print("Share contact")
        } label: {
            HStack {
                Text("Share Contact")
                    .font(.system(size: 22))

                Spacer()
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 32)
            .frame(height: 80)
            .background {
                RoundedRectangle(cornerRadius: 32)
                    .fill(cardColor)
            }
        }
        .buttonStyle(.plain)
    }

    func contactCard<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        content()
            .padding(32)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 34)
                    .fill(cardColor)
            }
    }

    var cardColor: Color {
        backgroundColor
            .mix(with: .black, by: 0.15)
    }
}

// MARK: - Top Bar

private extension ContactDetailView {

    var topBar2: some View {
        VStack {
            HStack {

                Button {
                    print("Back")
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 27, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(width: 92, height: 92)
                        .background {
                            Circle()
                                .fill(.ultraThinMaterial)
                                .opacity(0.4)
                        }
                        .overlay {
                            Circle()
                                .stroke(
                                    .white.opacity(0.25),
                                    lineWidth: 1
                                )
                        }
                }

                Spacer()

                Button("Edit") {
                    print("Edit")
                }
                .font(.system(size: 23, weight: .medium))
                .foregroundStyle(.white)
                .padding(.horizontal, 30)
                .frame(height: 92)
                .background {
                    Capsule()
                        .fill(.ultraThinMaterial)
                        .opacity(0.4)
                }
                .overlay {
                    Capsule()
                        .stroke(
                            .white.opacity(0.25),
                            lineWidth: 1
                        )
                }
            }
            .padding(.horizontal, 32)
            .padding(.top, 20)

            Spacer()
        }
        .allowsHitTesting(true)
    }
}

private extension ContactDetailView {

    var topBar: some View {
        GeometryReader { proxy in
            let safeAreaTop = proxy.safeAreaInsets.top
            let titleProgress = min(max((scrollOffset - 180) / 100, 0), 1)
            ZStack {
                // Sticky title background
                backgroundColor
                    .mix(with: .black, by: 0.18)
                    .opacity(titleProgress)
                    .ignoresSafeArea(edges: .top)
                
                VStack(spacing: 0) {
                    HStack {
                        Button {
                            print("Back")
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 27, weight: .medium))
                                .foregroundStyle(.white)
                                .frame(width: 60, height: 60)
                                .background {
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .opacity(0.4)
                                }
                                .overlay {
                                    Circle()
                                        .stroke(
                                            .white.opacity(0.25),
                                            lineWidth: 1
                                        )
                                }
                        }

                        Spacer()

                        Button("Edit") {
                            print("Edit")
                        }
                        .font(.system(size: 23, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 24)
                        .frame(height: 60)
                        .background {
                            Capsule()
                                .fill(.ultraThinMaterial)
                                .opacity(0.4)
                        }
                        .overlay {
                            Capsule()
                                .stroke(
                                    .white.opacity(0.25),
                                    lineWidth: 1
                                )
                        }
                    }
                    .padding(.horizontal, 20)

                    // Sticky name
                    Text(name)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .opacity(titleProgress)
                        .scaleEffect(
                            0.9 + (0.1 * titleProgress)
                        )
                        .padding(.top, 2)

                    Spacer()
                }
                .padding(.top, safeAreaTop + 4)
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(true)
    }
}


extension Color {

    func mix(
        with color: Color,
        by amount: CGFloat
    ) -> Color {
        let amount = min(max(amount, 0), 1)

        let uiColor1 = UIColor(self)
        let uiColor2 = UIColor(color)

        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0

        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0

        uiColor1.getRed(
            &r1,
            green: &g1,
            blue: &b1,
            alpha: &a1
        )

        uiColor2.getRed(
            &r2,
            green: &g2,
            blue: &b2,
            alpha: &a2
        )

        return Color(
            red: r1 + (r2 - r1) * amount,
            green: g1 + (g2 - g1) * amount,
            blue: b1 + (b2 - b1) * amount
        )
    }
}

struct ColorExtractingImage: View {

    let url: URL

    @Binding var extractedColor: Color

    var body: some View {
        AsyncImage(url: url) { phase in

            if case .success(let image) = phase {

                image
                    .resizable()
                    .scaledToFill()
                    .task {
                        await extractColor(from: image)
                    }

            } else {
                Color.gray.opacity(0.2)
            }
        }
    }

    private func extractColor(from image: Image) async {
        // Color extraction is performed from the downloaded UIImage.
    }
}

import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

actor ImageColorExtractor {

    private let context = CIContext()

    func extractColor(from data: Data) -> UIColor? {

        guard
            let image = UIImage(data: data),
            let cgImage = image.cgImage
        else {
            return nil
        }

        let ciImage = CIImage(cgImage: cgImage)

        let filter = CIFilter.areaAverage()
        filter.inputImage = ciImage
        filter.extent = ciImage.extent

        guard
            let outputImage = filter.outputImage,
            let bitmap = context.createCGImage(
                outputImage,
                from: CGRect(x: 0, y: 0, width: 1, height: 1)
            )
        else {
            return nil
        }

        let dataProvider = bitmap.dataProvider
        guard let data = dataProvider?.data else {
            return nil
        }

        let pointer = CFDataGetBytePtr(data)

        guard let pointer else {
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

struct RemoteImageResult {
    let image: UIImage
    let color: UIColor
}

#Preview {
    if let url = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDc425L193k7Fvr3k2OBsTJTZL4tFjsGKNOq_4ByyjYmHlhRq50cisgW0&s=10") {
        
        ContactDetailView(
            name: "Steve Jobs",
            email: "steve@apple.com",
            imageURL: url
        )
    }

}
