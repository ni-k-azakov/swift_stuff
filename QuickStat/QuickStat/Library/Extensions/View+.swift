//
//  View+.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 13.04.2023.
//

import SwiftUI

public extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    func blur(_ radius: CGFloat = 15, isFramed: Bool = false) -> some View {
        modifier(BlurView(cornerRadius: radius, isFramed: isFramed))
    }
    
    func inverseMask<M: View>(_ mask: M) -> some View {
        let inversed = mask
            .foregroundColor(.black)
            .background(Color.white)
            .compositingGroup()
            .luminanceToAlpha()
        return self.mask(inversed)
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
