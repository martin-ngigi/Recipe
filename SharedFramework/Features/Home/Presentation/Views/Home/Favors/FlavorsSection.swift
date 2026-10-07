/*
* Created by Martin Wainaina on 07/10/2026
*
* Feel free to contribute.
*/

//
//  FlavorsSection.swift
//  Recipe
//
//  Created by RAFIKI on 28/09/2026.
//

import SwiftUI

struct FlavorsSection: View {
    @Binding var selectedFlavor: RecipeFlavor
    var onTapSeeAll: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Button{
                onTapSeeAll()
            } label: {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Flavors >")
                            .font(.title2.bold())

                        Text("Explore recipes by taste")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()
                    
                    /*
                    Image(systemName: "slider.horizontal.3")
                        .font(.title3.weight(.medium))
                        .foregroundStyle(.secondary)
                        .accessibilityHidden(true)
                     */
                }
            }

            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(RecipeFlavor.allCases) { flavor in
                        
                        FlavorCard(
                            flavor: flavor,
                            isSelected: selectedFlavor == flavor
                        ) {
                            withAnimation(.snappy(duration: 0.25)) {
                                selectedFlavor = flavor
                            }
                        }
                    }
                }
                .padding(.vertical, 2)
            }
            .scrollIndicators(.hidden)
            .scrollClipDisabled()
        }
    }
}


#Preview {
    FlavorsSection(
        selectedFlavor: .constant(RecipeFlavor.savory),
        onTapSeeAll: {
            
        }
    )
        .padding()
}
