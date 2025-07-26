//
//  RatingView.swift
//  Recipe
//
//  Created by Hummingbird on 23/07/2025.
//

import SwiftUI

struct RatingView: View {
    @State private var rating: Int = 0
    @State private var comment: String = ""
    
    var onDismiss: () -> Void
    var onSubmit: (Int, String) -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    // isPresented = false // Dismiss when tapping outside
                }
            
            VStack(spacing: 20) {
                Text("Rate Your Experience")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 20)

                // Stars
                HStack {
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= rating ? "star.fill" : "star")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.yellow)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    rating = index
                                }
                            }
                            .scaleEffect(index == rating ? 1.5 : 1.0)
                    }
                }

                // Comment Box
                VStack(alignment: .leading, spacing: 8) {
                    Text("Leave a Comment")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    TextEditor(text: $comment)
                        .frame(height: 100)
                        //.background(Color.gray.opacity(0.3))
                        .background(.red)
                        .cornerRadius(7)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.gray, lineWidth: 0.3)
                        )
                }
                .padding(.horizontal)

                // Buttons
                HStack(spacing: 20) {
                    
                    CustomButton(
                        buttonName: "Cancel",
                        backgroundColor: Color.clear,
                        buttonNameColor: Color.theme.primaryColor
                    ) {
                        onDismiss()
                    }
                    
                    CustomButton(
                        buttonName: "Submit",
                        borderColor: Color.clear,
                        isDisabled: rating == 0 || comment.isEmpty
                    ) {
                        onSubmit(rating, comment)
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .padding()
            .background(Color.theme.whiteAndBlack)
            .cornerRadius(11)
            .frame(maxWidth: UIScreen.main.bounds.width * 0.94)
            .overlay(
                   RoundedRectangle(cornerRadius: 11)
                    .stroke(Color.theme.primaryColor, lineWidth: 1)
               )
            .padding()
            .shadow(radius: 10)
        }
        
    }
}

#Preview {
    RatingView(onDismiss: {}, onSubmit: { _, _ in})
}
