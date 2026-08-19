/*
* Created by Martin Wainaina on 19/08/2026
*
* Feel free to contribute.
*/

//
//  CustomTabsView.swift
//  Recipe
//
//  Created by RAFIKI on 19/08/2026.
//

import SwiftUI

import SwiftUI
import os

struct CustomTabsView<T: Hashable>: View {
    @Binding var tabs: [T]
    @Binding var selectedTab: T
    var onTap: (T, Int) -> Void
    var labelProvider: (T) -> String

    var body: some View {

        Picker(selection: $selectedTab, label: Text("")) {
            ForEach(tabs, id: \.self) { tab in
                Text(labelProvider(tab)).tag(tab)
                    .foregroundColor(Color.theme.blackAndWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .labelsHidden()
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: selectedTab) { _, newValue in
            if let index = tabs.firstIndex(of: newValue) {
                onTap(newValue, index)
            }
        }
    }
}


//#Preview {
//    CustomTabsView()
//}
