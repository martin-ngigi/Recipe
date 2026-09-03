/*
* Created by Martin Wainaina on 03/09/2026
*
* Feel free to contribute.
*/

//
//  ReactionView.swift
//  Recipe
//
//  Created by RAFIKI on 03/09/2026.
//

import SwiftUI



struct ReactionView: View {

    let reactions = ["🔥", "❤️", "😁"]

    @State private var animationTriggers = [0, 0, 0]

    var body: some View {
        HStack {
            ForEach(Array(reactions.enumerated()), id: \.element) { index, reaction in
                Text(reaction)
                    .font(.largeTitle)
                    .padding(8)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(12)
                    .phaseAnimator(
                        Phase.allCases,
                        trigger: animationTriggers[index]
                    ) { content, phase in
                        content
                            .scaleEffect(phase.scale)
                            .offset(y: phase.verticalOffset)
                            .foregroundStyle(phase.foregroundStyle)
                    } animation: { phase in
                        switch phase {
                        case .initial:
                            .smooth
                        case .move:
                            .easeInOut(duration: 0.3)
                        case .scale:
                            .spring(duration: 0.3, bounce: 0.7)
                        }
                    }
                    .onTapGesture {
                        animationTriggers[index] += 1
                    }
            }
        }
    }

    enum Phase: CaseIterable {
        case initial
        case move
        case scale

        var verticalOffset: Double {
            switch self {
            case .initial:
                0
            case .move, .scale:
                -64
            }
        }

        var scale: Double {
            switch self {
            case .initial:
                1
            case .move, .scale:
                1.5
            }
        }

        var foregroundStyle: Color {
            switch self {
            case .initial:
                .green
            case .move, .scale:
                .secondary
            }
        }
    }
}

#Preview {
    ReactionView()
}
