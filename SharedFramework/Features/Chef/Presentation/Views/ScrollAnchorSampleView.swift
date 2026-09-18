/*
* Created by Martin Wainaina on 26/08/2026
*
* Feel free to contribute.
*/

//
//  ScrollAnchorSampleView.swift
//  Recipe
//
//  Created by RAFIKI on 26/08/2026.
//

import SwiftUI

struct ScrollAnchorSampleView: View {
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8){
                    ForEach(1...10, id: \.self){ recipe in
                        Rectangle()
                            .frame(width: 250, height: 150)
                            .scrollTransition(.interactive, axis: .horizontal){ content, phase in
                                content
                                    .scaleEffect(1.0 - 0.12 * abs(phase.value))
                                    .rotation3DEffect(Angle(degrees: 20 * phase.value), axis: (0,1,0))
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        }
        .padding()
    }
}

#Preview {
    ScrollAnchorSampleView()
}
