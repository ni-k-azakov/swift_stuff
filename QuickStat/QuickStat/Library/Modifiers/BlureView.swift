//
//  BlureView.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 23.04.2023.
//

import SwiftUI

struct BlurView: ViewModifier {
    let cornerRadius: CGFloat
    let isFramed: Bool
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    BackgroundBlurView(style: .dark)
                        .cornerRadius(cornerRadius)
                    
                    if isFramed {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(lineWidth: 2)
                            .fill(Color.gray.opacity(0.12))
                    }
                }
            )
    }
}
