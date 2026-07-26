/*
* Created by Martin Wainaina on 26/07/2026
*
* Feel free to contribute.
*/

//
//  ContentView.swift
//  Chef
//
//  Created by RAFIKI on 26/07/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, \(AppTarget.current)!")
            
            Button("Tap me"){
                NotificationManager.shared.showNotification(
                    title: "Hello there",
                    body: "Button tapped successfully."
                )
            }
            .buttonBorderShape(.roundedRectangle)
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
