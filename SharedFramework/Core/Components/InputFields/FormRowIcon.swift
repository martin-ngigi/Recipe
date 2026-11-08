/*
* Created by Martin Wainaina on 08/11/2026
*
* Feel free to contribute.
*/

//
//  FormRowIcon.swift
//  Recipe
//

import SwiftUI

/// Small Settings-style icon tile used as the leading element of a list row.
struct FormRowIcon: View {
    let systemName: String
    var tint: Color = Color.theme.primaryColor

    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 30, height: 30)
            .background(tint.gradient, in: RoundedRectangle(cornerRadius: 7, style: .continuous))
            .accessibilityHidden(true)
    }
}

#Preview {
    HStack {
        FormRowIcon(systemName: "envelope.fill")
        FormRowIcon(systemName: "lock.fill", tint: .orange)
        FormRowIcon(systemName: "key.fill", tint: .green)
    }
    .padding()
}
