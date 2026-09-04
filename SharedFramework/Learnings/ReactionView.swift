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
                ReactionItem(reaction: reaction)
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

struct AnimationValues{
    var scale = 1.0
    var verticalStretch = 1.0
    var verticalTranslation = 0.0
    var angle = Angle.zero
}

struct ReactionViewCustom: View {

    let reactions = ["🔥", "❤️", "😁"]

    @State private var animationTriggers = [0, 0, 0]
    
    @State private var animationScaleTriggers = [0, 0, 0]
    @State private var animationVerticalTranslationTriggers = [0, 0, 0]
    @State private var animationVerticalStretchTriggers = [0, 0, 0]
    @State private var animationAngleTriggers = [0, 0, 0]
    
    var body: some View {
        
        VStack(spacing: 32){
            VStack(spacing: 8){
                Text("Scale Animation")
                HStack(spacing: 16) {
                    ForEach(Array(reactions.enumerated()), id: \.element) { index, reaction in
                        ReactionItem(reaction: reaction)
                            .keyframeAnimator(
                                initialValue: AnimationValues(),
                                trigger: animationScaleTriggers[index],
                                content: { content, value in
                                    content
                                        .rotationEffect(value.angle)
                                        .scaleEffect(value.scale)
                                        .scaleEffect(y: value.verticalStretch)
                                        .offset(y: value.verticalTranslation)
                                },
                                keyframes: { phrames in
                                    KeyframeTrack(\.scale){
                                        LinearKeyframe(1.0, duration: 0.36)
                                        SpringKeyframe(1.5, duration: 0.8)
                                        SpringKeyframe(1.0, spring: .bouncy)
                                    }
                                }
                            )
                            .onTapGesture {
                                animationScaleTriggers[index] += 1
                            }
                    }
                }
            }
            
            VStack(spacing: 8){
                Text("Vertical Translation Animation")
                HStack(spacing: 16) {
                    ForEach(Array(reactions.enumerated()), id: \.element) { index, reaction in
                        ReactionItem(reaction: reaction)
                            .keyframeAnimator(
                                initialValue: AnimationValues(),
                                trigger: animationVerticalTranslationTriggers[index],
                                content: { content, value in
                                    content
                                        .rotationEffect(value.angle)
                                        .scaleEffect(value.scale)
                                        .scaleEffect(y: value.verticalStretch)
                                        .offset(y: value.verticalTranslation)
                                },
                                keyframes: { phrames in
                                    KeyframeTrack(\.verticalTranslation){
                                        LinearKeyframe(0.0, duration: 0.1)
                                        SpringKeyframe(20.0, duration: 0.15, spring: .bouncy)
                                        SpringKeyframe(-60.0, duration: 1.0, spring: .bouncy)
                                        SpringKeyframe(0.0, spring: .bouncy)
                                    }
                                }
                            )
                            .onTapGesture {
                                animationVerticalTranslationTriggers[index] += 1
                            }
                    }
                }
            }
            
            VStack(spacing: 8){
                Text("Vertical Stretch Animation")
                HStack(spacing: 16) {
                    ForEach(Array(reactions.enumerated()), id: \.element) { index, reaction in
                        ReactionItem(reaction: reaction)
                            .keyframeAnimator(
                                initialValue: AnimationValues(),
                                trigger: animationVerticalStretchTriggers[index],
                                content: { content, value in
                                    content
                                        .rotationEffect(value.angle)
                                        .scaleEffect(value.scale)
                                        .scaleEffect(y: value.verticalStretch)
                                        .offset(y: value.verticalTranslation)
                                },
                                keyframes: { phrames in
                                    KeyframeTrack(\.verticalStretch){
                                        CubicKeyframe(1.0, duration: 0.1)
                                        CubicKeyframe(0.6, duration: 0.15)
                                        CubicKeyframe(1.5, duration: 0.1)
                                        CubicKeyframe(1.05, duration: 0.15)
                                        CubicKeyframe(1.0, duration: 0.88)
                                        CubicKeyframe(0.8, duration: 0.1)
                                        CubicKeyframe(1.04, duration: 0.4)
                                        CubicKeyframe(1.0, duration: 0.22)
                                    }
                                }
                            )
                            .onTapGesture {
                                animationVerticalStretchTriggers[index] += 1
                            }
                    }
                }
            }
            
            
            VStack(spacing: 8) {
                Text("Angle Animation")

                HStack(spacing: 16) {
                    ForEach(Array(reactions.enumerated()), id: \.element) { index, reaction in
                        ReactionItem(reaction: reaction)
                            .keyframeAnimator(
                                initialValue: AnimationValues(),
                                trigger: animationAngleTriggers[index]
                            ) { content, value in
                                content
                                    .rotationEffect(value.angle)
                                    .scaleEffect(value.scale)
                                    .scaleEffect(y: value.verticalStretch)
                                    .offset(y: value.verticalTranslation)
                            } keyframes: { _ in
                                KeyframeTrack(\.angle) {
                                    LinearKeyframe(.degrees(0), duration: 0.1)
                                    SpringKeyframe(.degrees(-15), duration: 0.15, spring: .bouncy)
                                    SpringKeyframe(.degrees(15), duration: 0.15, spring: .bouncy)
                                    SpringKeyframe(.degrees(-10), duration: 0.12, spring: .bouncy)
                                    SpringKeyframe(.degrees(10), duration: 0.12, spring: .bouncy)
                                    SpringKeyframe(.degrees(0), spring: .bouncy)
                                }
                            }
                            .onTapGesture {
                                animationAngleTriggers[index] += 1
                            }
                    }
                }
            }

            VStack(spacing: 8){
                Text("All Animations")
                HStack {
                    ForEach(Array(reactions.enumerated()), id: \.element) { index, reaction in
                        ReactionItem(reaction: reaction)
                            .keyframeAnimator(
                                initialValue: AnimationValues(),
                                trigger: animationTriggers[index],
                                content: { content, value in
                                    content
                                        .rotationEffect(value.angle)
                                        .scaleEffect(value.scale)
                                        .scaleEffect(y: value.verticalStretch)
                                        .offset(y: value.verticalTranslation)
                                },
                                keyframes: { phrames in
                                    
                                    KeyframeTrack(\.scale){
                                        LinearKeyframe(1.0, duration: 0.36)
                                        SpringKeyframe(1.5, duration: 0.8)
                                        SpringKeyframe(1.0, spring: .bouncy)
                                    }
                                    
                                    KeyframeTrack(\.verticalTranslation){
                                        LinearKeyframe(0.0, duration: 0.1)
                                        SpringKeyframe(20.0, duration: 0.15, spring: .bouncy)
                                        SpringKeyframe(-60.0, duration: 1.0, spring: .bouncy)
                                        SpringKeyframe(0.0, spring: .bouncy)
                                    }
                                    
                                    KeyframeTrack(\.verticalStretch){
                                        CubicKeyframe(1.0, duration: 0.1)
                                        CubicKeyframe(0.6, duration: 0.15)
                                        CubicKeyframe(1.5, duration: 0.1)
                                        CubicKeyframe(1.05, duration: 0.15)
                                        CubicKeyframe(1.0, duration: 0.88)
                                        CubicKeyframe(0.8, duration: 0.1)
                                        CubicKeyframe(1.04, duration: 0.4)
                                        CubicKeyframe(1.0, duration: 0.22)
                                    }
                                    
                                    KeyframeTrack(\.angle) {
                                        LinearKeyframe(.degrees(0), duration: 0.08)
                                        SpringKeyframe(.degrees(-20), duration: 0.12, spring: .bouncy)
                                        SpringKeyframe(.degrees(20), duration: 0.12, spring: .bouncy)
                                        SpringKeyframe(.degrees(-15), duration: 0.10, spring: .bouncy)
                                        SpringKeyframe(.degrees(15), duration: 0.10, spring: .bouncy)
                                        SpringKeyframe(.degrees(-5), duration: 0.08, spring: .bouncy)
                                        SpringKeyframe(.degrees(0), spring: .bouncy)
                                    }
                                }
                            )
                            .onTapGesture {
                                animationTriggers[index] += 1
                            }
                    }
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


struct ReactionItem: View {
    let reaction: String
    
    var body: some View {
        Text(reaction)
            .font(.largeTitle)
            .padding(8)
            .background(.gray.opacity(0.2))
            .cornerRadius(12)
    }
}

//#Preview {
//    ReactionView()
//}

#Preview{
    ReactionViewCustom()
}
