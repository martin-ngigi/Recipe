/*
* Created by Martin Wainaina on 03/09/2026
*
* Feel free to contribute.
*/

//
//  WarningAnimation.swift
//  Recipe
//
//  Created by RAFIKI on 03/09/2026.
//

import SwiftUI

struct WarningAnimation: View {
    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
            )
            .phaseAnimator([true, false]) { content, phase in
                content
                    //.opacity(phase ? 1.0 : 0.5)
                    .background(phase ? .orange : .red)
            } animation: { phase in
                    .easeInOut(duration: 1.0)
            }
    }
}

#Preview {
    WarningAnimation()
}
