//
//  CustomOverlayNavigation.swift
//  Recipe
//
//  Created by RAFIKI on 20/05/2026.
//

import SwiftUI

struct CustomOverlayNavigation: View {
    @EnvironmentObject var tabRouter: TabRouter
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabItemEntity.allCases, id: \.self) { item in
                Button {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                        tabRouter.selectedTab = item
                    }
                } label: {
                    MyCustomTab(
                        image: item.icon,
                        title: item.title,
                        isSelected: tabRouter.selectedTab == item,
                        bgColor: Color.theme.primaryColor
                    )
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 44)
                    .background {
                        if tabRouter.selectedTab == item{
                            RoundedRectangle(cornerRadius: 40, style: .continuous)
                                .fill(.gray.opacity(0.3))
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .fill(.ultraThinMaterial.opacity(0.9))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .strokeBorder(Color.gray.opacity(0.5), lineWidth: 0.3)
        }
        .safeAreaPadding(.bottom)
        .padding(.horizontal, 20)
    }
}

#Preview {
    CustomOverlayNavigation()
}
