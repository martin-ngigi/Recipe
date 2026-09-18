/*
* Created by Martin Wainaina on 29/07/2026
*
* Feel free to contribute.
*/

//
//  CustomButton.swift
//  Recipe
//
//  Created by Martin on 13/03/2025.
//

import SwiftUI

struct CustomButton: View {
    var buttonName: String

    var leadingIcon: String = ""
    var leadingImage: String = ""
    var trailingIcon: String = ""
    var trailingImage: String = ""

    var foregroundStyle = Color.theme.blackAndWhite
    var backgroundColor = Color.theme.primaryColor
    var borderColor = Color.theme.primaryColor
    var buttonNameColor = Color.theme.whiteColor

    var isDisabled: Bool = false
    var isLoading: Bool = false
    var isFilled = true
    var controlSize = ControlSize.large
    var buttonSizing = ButtonSizing.flexible
    var buttonBorderShape: SwiftUI.ButtonBorderShape = .capsule
    var onTap: () -> Void


    var tintColor: Color {
        if isDisabled || isLoading{
            return Color.gray
        }
        return backgroundColor
    }

    var localButtonColor: Color {
        return isDisabled ? Color.theme.whiteColor : buttonNameColor
    }

    var body: some View {
        Button {
            if !isDisabled {
                onTap()
            }
        } label: {
            HStack(spacing: 8) {
                if !leadingImage.isEmpty && !isLoading {
                    Image(leadingImage)
                }
                else if !leadingIcon.isEmpty && !isLoading {
                    Image(systemName: leadingIcon)
                        .imageScale(.large)
                }
                
                if isLoading {
                    ProgressView()
                        .tint(.primary)
                }

                if !buttonName.isEmpty {
                    Text(buttonName)
                        .font(.body)
                        .foregroundColor(localButtonColor)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.9)
                }
                
                if !trailingIcon.isEmpty {
                    Image(systemName: trailingIcon)
                        .imageScale(.large)
                }
                if !trailingImage.isEmpty {
                    Image(trailingImage)
                }
            }
            .foregroundColor(foregroundStyle)
        }
        .animation(.easeInOut(duration: 0.15), value: isDisabled)
        .glassButtonStyle(isFilled: isFilled)
        .buttonBorderShape(buttonBorderShape)
        .buttonSizing(buttonSizing)
        .controlSize(controlSize)
        .tint(tintColor)
    }
    
}

#Preview {
    CustomButton(
        buttonName: "Login With Email",
        isDisabled: true,
        isFilled: true,
        onTap: {

        }
    )
    .padding()
}
