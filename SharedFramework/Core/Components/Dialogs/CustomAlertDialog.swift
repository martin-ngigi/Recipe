/*
* Created by Martin Wainaina on 29/07/2026
*
* Feel free to contribute.
*/

//
//  CustomAlertDialog.swift
//  Recipe
//
//  Created by Hummingbird on 12/07/2025.
//

import SwiftUI


struct CustomAlertDialog<Content: View>: View {
    @Binding var isPresented: Bool

    var title: String
    var text: String
    var confirmButtonText: String = ""
    var dismissButtonText: String
    var imageName: String

    @ViewBuilder var content: () -> Content

    var onDismiss: () -> Void
    var onConfirmation: () -> Void

    @ScaledMetric(relativeTo: .body) private var iconSize: CGFloat = 54

    var body: some View {
        ZStack {

            if isPresented {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        // isPresented = false
                    }

                VStack(spacing: 8) {

                    Text(title)
                        .font(.appHeadline)
                        .multilineTextAlignment(.center)

                    if !imageName.isEmpty {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconSize, height: iconSize)
                    }

                    
                    Text(text)
                        .font(.appCallout)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)

                    content()

                    HStack {

                        if !dismissButtonText.isEmpty {
                            CustomButton(
                                buttonName: dismissButtonText,
                                height: 24,
                                backgroundColor: Color.clear,
                                borderColor: Color.theme.blackAndWhite,
                                buttonNameColor: Color.theme.blackAndWhite,
                                isFilled: false,
                                onTap: {
                                    onDismiss()
                                }
                            )
                        }

                        if !confirmButtonText.isEmpty {
                            CustomButton(
                                buttonName: confirmButtonText,
                                height: 24,
                                onTap: {
                                    onConfirmation()
                                }
                            )
                        }
                    }
                }
                .padding()
                .glassCard()
                .frame(maxWidth: UIScreen.main.bounds.width * 0.94)
                .padding()
                .shadow(color: .black.opacity(0.2), radius: 20, y: 10)
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isPresented)
    }
}

extension CustomAlertDialog where Content == EmptyView {
    init(
        isPresented: Binding<Bool>,
        title: String,
        text: String,
        confirmButtonText: String,
        dismissButtonText: String,
        imageName: String,
        onDismiss: @escaping () -> Void,
        onConfirmation: @escaping () -> Void
    ) {
        self._isPresented = isPresented
        self.title = title
        self.text = text
        self.confirmButtonText = confirmButtonText
        self.dismissButtonText = dismissButtonText
        self.imageName = imageName
        self.content = { EmptyView() }
        self.onDismiss = onDismiss
        self.onConfirmation = onConfirmation
    }
}

extension CustomAlertDialog where Content == AnyView {
    init(
        isPresented: Binding<Bool>,
        entity: DialogEntity
    ) {
        self._isPresented = isPresented
        self.title = entity.title
        self.text = entity.message
        self.confirmButtonText = entity.confirmButtonText
        self.dismissButtonText = entity.dismissButtonText
        self.imageName = entity.icon
        self.content = { entity.content?() ?? AnyView(EmptyView()) }
        self.onDismiss = { entity.onDismiss?() }
        self.onConfirmation = { entity.onConfirm?() }
    }
}

#Preview {
    ScrollView{
        VStack{
            Text("View Goes here")
                .frame(maxWidth: .infinity)
        }
    }
    .overlay{
        CustomAlertDialog(
            isPresented: .constant(true),
            title: "Oops",
            text: "Error occurred...",
            confirmButtonText: "Retry",
            dismissButtonText: "Okay",
            imageName: "",
            content: {
                Text("Additional content")
            },
            onDismiss: {

            },
            onConfirmation: {

            }
        )
    }
}
