//
//  MyCustomTab.swift
//  Recipe
//
//  Created by RAFIKI on 09/04/2026.
//

import SwiftUI

struct MyCustomTab: View {
    let image: String
    let title: String
    let isSelected: Bool
    let bgColor: Color

    var body: some View {
        VStack {
            Image(systemName: image)
                .font(.system(size: 17, weight: isSelected ? .semibold : .regular))
                .foregroundStyle(isSelected ? bgColor : Color.primary)
                .symbolEffect(.bounce, value: isSelected)
                .animation(.spring(response: 0.35, dampingFraction: 0.7), value: isSelected)

            Text(title)
                .font(.system(size: 10, weight: isSelected ? .semibold : .regular))
                .foregroundStyle(isSelected ? bgColor : Color.primary)
                .opacity(isSelected ? 1 : 0.8)
        }
    }

    var body1: some View {
        VStack(spacing: 5) {
            ZStack {
                if isSelected {
                    Capsule()
                        .fill(.ultraThinMaterial)
                        .overlay {
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            bgColor.opacity(0.55),
                                            bgColor.opacity(0.25)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        }
                        .overlay {
                            // Glass sheen
                            Capsule()
                                .strokeBorder(
                                    LinearGradient(
                                        colors: [
                                            Color.white.opacity(0.7),
                                            Color.white.opacity(0.1)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 0.6
                                )
                        }
                        .shadow(color: bgColor.opacity(0.4), radius: 8, x: 0, y: 4)
                        .transition(.scale(scale: 0.8).combined(with: .opacity))
                }
            }
            .frame(width: isSelected ? 52 : 36, height: 36)
            .overlay {
                Image(systemName: image)
                    .font(.system(size: 17, weight: isSelected ? .semibold : .regular))
                    .foregroundStyle(
                        isSelected
                            ? AnyShapeStyle(
                                LinearGradient(
                                    colors: [bgColor, bgColor.opacity(0.7)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            : AnyShapeStyle(Color.primary.opacity(0.45))
                    )
                    .symbolEffect(.bounce, value: isSelected)
            }
            .animation(.spring(response: 0.35, dampingFraction: 0.7), value: isSelected)

            // Label
            Text(title)
                .font(.system(size: 10, weight: isSelected ? .semibold : .regular))
                .foregroundStyle(isSelected ? bgColor : Color.primary.opacity(0.4))
                .opacity(isSelected ? 1 : 0.8)
        }
    }
}
