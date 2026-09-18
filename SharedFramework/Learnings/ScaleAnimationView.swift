/*
* Created by Martin Wainaina on 03/09/2026
*
* Feel free to contribute.
*/

//
//  ScaleAnimationView.swift
//  Recipe
//
//  Created by RAFIKI on 03/09/2026.
//

import SwiftUI

struct ScaleAnimationView: View {
    @State var isSelected = false
    
    var body: some View {
        Image("sheep")
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .animation(.smooth){
                $0.shadow(radius: isSelected ? 12 : 8)
            }
            .animation(.bouncy){
                $0.scaleEffect(isSelected ? 1.5 : 1.0)
            }
            .onTapGesture {
                isSelected.toggle()
            }
    }
}

#Preview {
    ScaleAnimationView()
}
