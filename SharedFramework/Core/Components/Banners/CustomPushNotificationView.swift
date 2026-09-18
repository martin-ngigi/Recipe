/*
* Created by Martin Wainaina on 06/09/2026
*
* Feel free to contribute.
*/

//
//  CustomPushNotificationView.swift
//  Recipe
//
//  Created by RAFIKI on 06/09/2026.
//

import SwiftUI
import UIKit

enum NotificationType {
    case regular
    case success
    case warning
    case error

    var icon: String {
        switch self {
        case .regular:
            return "bell.fill"
        case .success:
            return "checkmark.circle.fill"
        case .warning:
            return "exclamationmark.triangle.fill"
        case .error:
            return "xmark.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .regular:
            return .blue
        case .success:
            return .green
        case .warning:
            return .orange
        case .error:
            return .red
        }
    }
}

struct PopNotificationData {
    var title: String = ""
    let message: String
    var icon: String = ""
    var iconColor: Color = .white
    var type = NotificationType.regular
    var displayDuration: TimeInterval = 3.0
}

struct CustomPushNotificationView: View {

    var data: PopNotificationData?
    @Binding var isPresented: Bool

    @State private var offset: CGFloat = -250
    @State private var dragOffset: CGFloat = 0
    @State private var dismissTask: Task<Void, Never>?

    private let dismissThreshold: CGFloat = -80

    var body: some View {
        GeometryReader { geometry in
            VStack {

                if isPresented {
                    notificationView
                        .offset(y: offset + dragOffset)
                        .gesture(dragGesture)
                        .onAppear {
                            show()
                        }
                }

                Spacer()
            }
            .padding(.top, geometry.safeAreaInsets.top)
            .ignoresSafeArea(edges: .top)
        }
        .onDisappear {
            dismissTask?.cancel()
        }
    }

    private var notificationView: some View {
        HStack(spacing: 12) {

            Group {
                if let icon = data?.icon, !icon.isEmpty {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(data?.type.color ?? Color.theme.blackAndWhite)

                }
                else {
                    Image(systemName: data?.type.icon ?? "bell")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(data?.type.color ?? Color.theme.blackAndWhite)
                }
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(data?.title ?? "")
                    .font(.body)
                    .fontWeight(.semibold)

                Text(data?.message ?? "")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            Spacer(minLength: 0)
        }
        .padding(16)
        .glassEffectCustomRectangular()
        .padding(.horizontal, 8)
    }

    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 10)
            .onChanged { value in
                if value.translation.height < 0 {
                    dragOffset = value.translation.height
                }
            }
            .onEnded { value in
                if value.translation.height < dismissThreshold {
                    dismiss()
                }
                else {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                        dragOffset = 0
                    }
                }
            }
    }

    private func show() {

        dismissTask?.cancel()
        let haptic = UIImpactFeedbackGenerator(style: .light)
        haptic.prepare()

        withAnimation(.spring(response: 0.55, dampingFraction: 0.78)) {
            offset = 0
        }

        haptic.impactOccurred()

        // Automatically dismiss after a short period
        dismissTask = Task { @MainActor in

            try? await Task.sleep(for: .seconds(data?.displayDuration ?? 3.0))
            guard !Task.isCancelled else { return }
            dismiss()
        }
    }

    private func dismiss() {
        dismissTask?.cancel()
        withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
            offset = -250
            dragOffset = 0
        }

        Task { @MainActor in

            try? await Task.sleep(for: .milliseconds(350))
            guard !Task.isCancelled else { return }
            isPresented = false
        }
    }
}

#Preview {
    CustomPushNotificationView(
        data: PopNotificationData(
            title: "Successful",
            message: "This is where success message goes.",
            icon: "checkmark.circle.fill",
        ),
        isPresented: .constant(true)
    )
}
