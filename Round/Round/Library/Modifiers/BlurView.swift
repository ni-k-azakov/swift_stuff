//
//  BlureView.swift
//  Round
//
//  Created by Nikita Kazakov on 23.04.2023.
//

import SwiftUI

struct BlurView: ViewModifier {
    let cornerRadius: CGFloat
    let isFramed: Bool
    let style: UIBlurEffect.Style
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    BackgroundBlurView(style: style)
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
