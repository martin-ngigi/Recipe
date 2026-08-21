/*
* Created by Martin Wainaina on 17/08/2026
*
* Feel free to contribute.
*/

//
//  ChefQuoteView.swift
//  Recipe
//
//  Created by RAFIKI on 17/08/2026.
//

import SwiftUI


struct ChefQuote {
    let quote: String
    let chef: String
}

@available(iOS 26.0, *)
struct ChefQuoteView: View {
    
    let quotes = [
        ChefQuote(quote: "A great chef is first a great technician.", chef: "Jacques Pépin"),
        ChefQuote(quote: "You can't cook if you don't like people.", chef: "Joël Robuchon"),
        ChefQuote(quote: "No rules. Don't be afraid to do whatever you want.", chef: "Masaharu Morimoto")
    ]
    
    @State private var currentQuote: ChefQuote? = ChefQuote(quote: "A great chef is first a great technician.", chef: "Jacques Pépin")
    @Environment(\.tabViewBottomAccessoryPlacement) var placement
    
    var body: some View {
        Group {
            if let currentQuote {
                if placement == .inline {
                    HStack(spacing: 6) {
                        Image(systemName: "quote.opening")
                            .font(.caption)
                            .foregroundStyle(.tint)
                        
                        Text("“\(currentQuote.quote)” — ")
                            .font(.caption) +
                        Text(currentQuote.chef)
                            .font(.caption)
                            .bold()
                    }
                }
                else {
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "lightbulb.fill")
                            .font(.title2)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("“\(currentQuote.quote)”")
                                .font(.body)
                                .italic()
                            
                            Text("— \(currentQuote.chef)")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding()
                }
            }
            else {
                Text("Cook Like a chef")
            }
        }
        .onAppear {
            currentQuote = quotes.randomElement()
        }
    }
}

#Preview {
    if #available(iOS 26.0, *) {
        ChefQuoteView()
    }
    else {
    }
}
