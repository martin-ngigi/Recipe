/*
* Created by Martin Wainaina on 27/08/2026
*
* Feel free to contribute.
*/

//
//  BadgeTransition.swift
//  Recipe
//
//  Created by RAFIKI on 27/08/2026.
//

import SwiftUI

struct CustomFlipTransaction: Transition{
    
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .rotation3DEffect(
                .degrees(phase.isIdentity ? 0 : (phase.value * 180)), axis: (x: 0, y: 1, z: 0)
            )
            .opacity(phase.isIdentity ? 1 : 0)
            
    }
}

struct BadgeTransition: View {
    
    @State var isEarned = false
    
    var body: some View {
        VStack(spacing: 32){
            
            Group{
                if isEarned{
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
                else {
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .grayscale(1.0)
                }
            }
            .transition(CustomFlipTransaction())
            
            Button("Show"){
                isEarned.toggle()
            }
            .padding()
            .glassEffect()
        }
    }
}

#Preview {
    BadgeTransition()
}
