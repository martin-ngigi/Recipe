/*
* Created by Martin Wainaina on 19/08/2026
*
* Feel free to contribute.
*/

//
//  FilterPicker.swift
//  Recipe
//
//  Created by RAFIKI on 19/08/2026.
//

import SwiftUI

struct FilterPicker: View {
    var body: some View {
        HStack{
            Image(systemName: "line.3.horizontal.decrease.circle.fill")
            
            VStack(spacing: 2){
                Text("Filtered by")
                Text("Unread \(Image(systemName: "chevron.down"))")
                    .foregroundStyle(Color.blue)
            }
            .font(.caption)
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 2)
    }
}

#Preview {
    FilterPicker()
}
