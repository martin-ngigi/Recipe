//
//  ToastViewModel.swift
//  Recipe
//
//  Created by RAFIKI on 09/04/2026.
//

import Foundation
import SwiftUI

final class ToastViewModel: ObservableObject {
    @Published var toast: Toast?

    private var workItem: DispatchWorkItem?

    func showToast(_ toast: Toast) {
        self.toast = toast

        UIImpactFeedbackGenerator(style: .light).impactOccurred()

        if toast.duration > 0 {
            workItem?.cancel()

            let task = DispatchWorkItem { [weak self] in
                //                guard let self = self else { return }
                self?.dismissToast()
            }

            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }

    func dismissToast() {
        DispatchQueue.main.async {
            withAnimation {
                self.toast = nil
            }
        }

        workItem?.cancel()
        workItem = nil
    }

    deinit {}
}
