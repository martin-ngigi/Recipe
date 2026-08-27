/*
* Created by Martin Wainaina on 27/08/2026
*
* Feel free to contribute.
*/

//
//  ActivityProgressView.swift
//  Recipe
//
//  Created by RAFIKI on 27/08/2026.
//

import SwiftUI

struct ActivityProgressView: View {
    var completionValue: Double
    
    let barWidth = 80.0
    let barHeight = 10.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            
            Text(completionValue, format: .percent.precision(.fractionLength(0)))
                .font(.title3)
                .opacity(completionValue > 0 ? 1.0 : 0.0)
                .contentTransition(.numericText())
                .animation(.smooth, value: completionValue)
            
            RoundedRectangle(cornerRadius: barHeight * 0.5)
                .frame(width: barWidth * completionValue, height: barHeight)
                .opacity(completionValue > 0 ? 1.0 : 0.0)
        }
        //.animation(.bouncy(extraBounce: 0.2), value: completionValue)
        .animation(.spring(bounce: 0.6), value: completionValue)

    }
}

struct ActivityProgressPreView: View {
    @State var completionValue: Double = 0.1
    
    var body: some View{
        ActivityProgressView(completionValue: completionValue)
            .onTapGesture {
                completionValue += 0.16
            }
    }
}

#Preview {
    ActivityProgressPreView()
}
