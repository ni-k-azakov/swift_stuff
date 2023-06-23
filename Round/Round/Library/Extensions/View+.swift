//
//  View+.swift
//  Round
//
//  Created by Nikita Kazakov on 23.06.2023.
//

import SwiftUI

extension View {
    func blur(
        _ style: UIBlurEffect.Style = .dark,
        radius: CGFloat = 15,
        isFramed: Bool = false
    ) -> some View {
        modifier(BlurView(cornerRadius: radius, isFramed: isFramed, style: style))
    }
}
