//
//  BackgroundBlurView.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 23.04.2023.
//

import SwiftUI

struct BackgroundBlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
