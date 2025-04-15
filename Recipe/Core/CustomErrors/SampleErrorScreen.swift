//
//  SampleErrorScreen.swift
//  Recipe
//
//  Created by Martin on 15/04/2025.
//

import SwiftUI

struct SampleErrorScreen: View {
    
    @Environment(\.showError) private var showError
    
    var body: some View {
        VStack{
            Button("Throw Error"){
                showError(SampleError.operationFailed, "Operation has failed. Please try again later.")
            }
        }
        .padding()
    }
}


// Only for the previews
struct SampleErrorScreenContainer: View {
    @State private var errorWrapper : ErrorWrapper? = nil
    var body: some View {
        SampleErrorScreen()
            .environment(\.showError, ShowErrorAction(action: showError))
            .sheet(item: $errorWrapper) { errorWrapper in
                Text(errorWrapper.guidance)
            }
    }
    
    private func showError(error: Error, guidance: String) {
        errorWrapper = ErrorWrapper(error: error, guidance: guidance)
    }
}

#Preview {
    NavigationStack {
        SampleErrorScreenContainer()
    }
}
