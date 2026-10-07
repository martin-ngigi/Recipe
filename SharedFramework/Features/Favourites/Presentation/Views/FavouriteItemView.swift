/*
* Created by Martin Wainaina on 13/09/2026
*
* Feel free to contribute.
*/

//
//  FavouriteItemView.swift
//  Recipe
//
//  Created by Martin on 07/04/2025.
//

import SwiftUI

/// Shared layout constants for the favourites screen.
enum FavouritesLayout {
    static let spacing: CGFloat = 16
    static let cornerRadius: CGFloat = 20
    static let imageHeight: CGFloat = 200
    /// Adaptive: one column on iPhone, multiple on iPad / landscape.
    static let columns = [
        GridItem(.adaptive(minimum: 320, maximum: 520), spacing: spacing, alignment: .top)
    ]
}

struct FavouriteItemView: View {
    let recipe: RecipeModel
    var onTap: () -> Void
    var onTapFavourite: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // The heart is a sibling of the card button, not nested inside it,
            // so VoiceOver and hit-testing treat them as two separate controls.
            Button(action: onTap) {
                card
            }
            .buttonStyle(CardButtonStyle())
            .accessibilityHint("Opens recipe details")

            favouriteButton
        }
    }

    private var card: some View {
        VStack(alignment: .leading, spacing: 0) {
            CustomImageView(
                url: recipe.image,
                width: .infinity,
                height: FavouritesLayout.imageHeight
            )
            .frame(maxWidth: .infinity)
            .frame(height: FavouritesLayout.imageHeight)
            .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)

                Text(recipe.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: FavouritesLayout.cornerRadius, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)
        .contentShape(RoundedRectangle(cornerRadius: FavouritesLayout.cornerRadius, style: .continuous))
    }

    private var favouriteButton: some View {
        Button(action: onTapFavourite) {
            Image(systemName: "heart.fill")
                .font(.body.weight(.semibold))
                .foregroundStyle(Color.theme.primaryColor)
                .frame(width: 44, height: 44) // HIG minimum tap target
                .background(.ultraThinMaterial, in: Circle())
        }
        .buttonStyle(.plain)
        .padding(10)
        .accessibilityLabel("Remove \(recipe.name) from favourites")
    }
}

private struct CardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

#Preview {
    FavouriteItemView(
        recipe: RecipeModel.dummyList[0],
        onTap: {},
        onTapFavourite: {}
    )
    .padding()
    .background(Color(.systemGroupedBackground))
    .environmentObject(ThemesViewModel())
}
