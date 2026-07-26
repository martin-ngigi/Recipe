//
//  TappableTextFieldStyle.swift
//  Recipe
//
//  Created by RAFIKI on 09/04/2026.
//

import Foundation
import SwiftUI

struct TappableTextFieldStyle: TextFieldStyle {  // https://stackoverflow.com/questions/56795712/swiftui-textfield-touchable-area
    @FocusState private var textFieldFocused: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .focused($textFieldFocused)
            .onTapGesture {
                textFieldFocused = true
            }
    }
}
