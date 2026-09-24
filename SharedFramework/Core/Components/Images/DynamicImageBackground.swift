/*
* Created by Martin Wainaina on 24/09/2026
*
* Feel free to contribute.
*/

//
//  DynamicImageBackground.swift
//  Recipe
//
//  Created by RAFIKI on 24/09/2026.
//

import SwiftUI

struct DynamicImageBackground<Content: View>: View {

    let url: URL?
    let content: Content

    @State private var backgroundColor: Color = .gray.opacity(0.2)

    init(
        url: URL?,
        @ViewBuilder content: () -> Content
    ) {
        self.url = url
        self.content = content()
    }

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            content
        }
        .task(id: url) {
            await extractColor()
        }
    }

    private func extractColor() async {
        guard let url else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            guard let image = UIImage(data: data),
                  let uiColor = image.averageColor() else {
                return
            }

            await MainActor.run {
                backgroundColor = Color(uiColor: uiColor)
            }
        } catch {
            // Handle image loading failure if required
        }
    }
}
#Preview {
    let urlString = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDc425L193k7Fvr3k2OBsTJTZL4tFjsGKNOq_4ByyjYmHlhRq50cisgW0&s=10"
    DynamicImageBackground(url: URL(string: urlString)) {
        VStack {
            CustomImageView(url: urlString)
                .cornerRadius(16)
                .padding()
            Text("Text here")
        }
    }
}
