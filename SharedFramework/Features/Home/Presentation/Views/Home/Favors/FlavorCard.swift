/*
* Created by Martin Wainaina on 07/10/2026
*
* Feel free to contribute.
*/

//
//  FlavorCard.swift
//  Recipe
//
//  Created by RAFIKI on 28/09/2026.
//

import SwiftUI


struct FlavorCard: View {
    let flavor: RecipeFlavor
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                Image(systemName: flavor.symbol)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(flavor.color)
                    .frame(width: 48, height: 48)
                    .background(
                        flavor.color.opacity(0.12),
                        in: Circle()
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(flavor.rawValue)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.primary)

                    Text(flavor.subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            .padding(14)
            .frame(width: 132, alignment: .leading)
            .background {
                RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                )
                .fill(.ultraThinMaterial)
            }
            .overlay {
                RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                )
                .strokeBorder(
                    isSelected
                        ? flavor.color.opacity(0.8)
                        : Color.primary.opacity(0.07),
                    lineWidth: isSelected ? 1.5 : 1
                )
            }
            .contentShape(RoundedRectangle(cornerRadius: 20))
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .scrollTransition(.animated(.snappy)) { content, phase in
            content
                .scaleEffect(phase.isIdentity ? 1 : 0.96)
                .opacity(phase.isIdentity ? 1 : 0.8)
        }
    }
}

#Preview {
    FlavorCard(
        flavor: RecipeFlavor.sweet, 
        isSelected: false,
        action: {}
    )
    .padding()
}
