/*
* Created by Martin Wainaina on 02/09/2026
*
* Feel free to contribute.
*/

//
//  AnimationView.swift
//  Recipe
//
//  Created by RAFIKI on 01/09/2026.
//

import SwiftUI

//https://pngtree.com/
struct AnimationView: View {
    
    @State var isSelected = false
    
    var body: some View {
        Image("sheep")
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .scaleEffect(isSelected ? 1.5 : 1.0)
            .onTapGesture {
                withAnimation {
                    isSelected.toggle()
                }
            }
    }
}

#Preview {
    AnimationView()
}
