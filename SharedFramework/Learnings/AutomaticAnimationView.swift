/*
* Created by Martin Wainaina on 17/09/2026
*
* Feel free to contribute.
*/

//
//  AutomaticAnimationView.swift
//  Recipe
//
//  Created by RAFIKI on 14/09/2026.
//

import SwiftUI

struct AutomaticAnimationView: View {

    let focalPoint: CGPoint

    private let maximumDistance: CGFloat = 300

    var body: some View {
        Image("sheep")
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .visualEffect { content, geometry in
                content
                    .scaleEffect(contentScale(in: geometry))
                    .grayscale(contentGrayScale(in: geometry))
                    .saturation(contentSaturation(in: geometry))
            }
    }

    private func distance(in geometry: GeometryProxy) -> CGFloat {
        let frame = geometry.frame(in: .named("sheepGrid"))

        let center = CGPoint(
            x: frame.midX,
            y: frame.midY
        )

        let dx = center.x - focalPoint.x
        let dy = center.y - focalPoint.y

        return sqrt((dx * dx) + (dy * dy))
    }

    private func normalizedDistance(in geometry: GeometryProxy) -> CGFloat {
        min(distance(in: geometry) / maximumDistance, 1)
    }

    private func contentScale(in geometry: GeometryProxy) -> CGFloat {
        let distance = normalizedDistance(in: geometry)

        return 1.2 - (distance * 0.4)
    }

    private func contentGrayScale(in geometry: GeometryProxy) -> Double {
        let distance = normalizedDistance(in: geometry)

        return distance * 0.9
    }

    private func contentSaturation(in geometry: GeometryProxy) -> Double {
        let distance = normalizedDistance(in: geometry)

        return 1.0 - (distance * 0.7)
    }
}

struct SheepGridView: View {

    private let columns = [
        GridItem(.adaptive(minimum: 100), spacing: 16)
    ]

    var body: some View {
        GeometryReader { geometry in
            TimelineView(.animation) { timeline in
                let time = timeline.date.timeIntervalSinceReferenceDate

                let width = geometry.size.width
                let height = geometry.size.height

                let centerX = width / 2
                let centerY = height / 2

                let radiusX = max(width / 2 - 60, 0)
                let radiusY = max(height / 2 - 60, 0)

                let focalPoint = CGPoint(
                    x: centerX + cos(time * 0.6) * radiusX,
                    y: centerY + sin(time * 0.8) * radiusY
                )

                ScrollView {
                    LazyVGrid(
                        columns: columns,
                        spacing: 16
                    ) {
                        ForEach(0..<30, id: \.self) { _ in
                            AutomaticAnimationView(
                                focalPoint: focalPoint
                            )
                        }
                    }
                    .padding()
                }
            }
        }
        .coordinateSpace(name: "sheepGrid")
    }
}

#Preview {
    SheepGridView()
}
