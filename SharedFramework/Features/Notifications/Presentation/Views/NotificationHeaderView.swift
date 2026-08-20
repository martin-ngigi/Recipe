/*
* Created by Martin Wainaina on 20/08/2026
*
* Feel free to contribute.
*/

//
//  NotificationHeaderView.swift
//  Recipe
//
//  Created by RAFIKI on 19/08/2026.
//

import SwiftUI

struct NotificationHeaderView: View {
    let date: String
    
    var body: some View {
        HStack {
            
            Text(date)
                .font(.body)
                .foregroundColor(.primary)
                .padding(4)
                .background(Color(.systemGroupedBackground))
                .cornerRadius(4)
            
            Spacer()
            
        }
        
    }
}

#Preview {
    NotificationHeaderView(date: "24 Nov 2026")
}
