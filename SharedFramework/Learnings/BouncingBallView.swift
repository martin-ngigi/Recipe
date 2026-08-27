/*
* Created by Martin Wainaina on 27/08/2026
*
* Feel free to contribute.
*/

//
//  BouncingBallView.swift
//  Recipe
//
//  Created by RAFIKI on 27/08/2026.
//

import SwiftUI

enum BallPhase: CaseIterable{
    case drop, squish, expand, rise
    
    var yOffset: Double{
        switch self {
        case .drop: 0
        case .squish: 5
        case .expand: 0
        case .rise: -40
        }
    }
    
    var scale: CGSize{
        switch self {
        case .squish: CGSize(width: 1.2, height: 0.75)
        case .drop, .expand, .rise: CGSize(width: 1, height: 1)
        }
    }
}

struct BouncingBallView: View {
    var body: some View {
        PhaseAnimator(BallPhase.allCases) { phase in
            Circle()
                .frame(width: 20)
                .offset(x: 0, y: phase.yOffset)
                .scaleEffect(phase.scale, anchor: .bottom)
        } animation: { phase in
            switch phase{
            case .drop: .easeIn(duration: 0.6)
            case .squish: .easeIn(duration: 0.1)
            case .expand: .easeIn(duration: 0.1)
            case .rise: .easeOut(duration: 0.6)
            }
        }
    }
}

#Preview {
    BouncingBallView()
}
