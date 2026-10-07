/*
* Created by Martin Wainaina on 15/08/2026
*
* Feel free to contribute.
*/

//
//  FavouritesShimmerView.swift
//  Recipe
//
//  Created by RAFIKI on 15/08/2026.
//

import SwiftUI

/// Loading placeholder that mirrors the real card layout.
struct FavouritesShimmerView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: FavouritesLayout.columns, spacing: FavouritesLayout.spacing) {
                ForEach(0..<3, id: \.self) { _ in
                    FavouriteCardSkeleton()
                }
            }
            .padding(FavouritesLayout.spacing)
        }
        .scrollDisabled(true)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Loading favourites")
    }
}

private struct FavouriteCardSkeleton: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var isDimmed = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .fill(Color(.tertiarySystemFill))
                .frame(height: FavouritesLayout.imageHeight)

            VStack(alignment: .leading, spacing: 8) {
                bar(width: 180, height: 16)
                bar(width: nil, height: 12)
                bar(width: 220, height: 12)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: FavouritesLayout.cornerRadius, style: .continuous))
        .opacity(isDimmed ? 0.55 : 1)
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
                isDimmed = true
            }
        }
    }

    private func bar(width: CGFloat?, height: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 4, style: .continuous)
            .fill(Color(.tertiarySystemFill))
            .frame(width: width, height: height)
    }
}

#Preview {
    FavouritesShimmerView()
        .background(Color(.systemGroupedBackground))
}
