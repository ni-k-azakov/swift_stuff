//
//  SubtractedText.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 24.04.2023.
//

import SwiftUI

struct SubtractedText: View {
    let text: String
    let font: Font
    let gradient: LinearGradient
    let cornerRadius: CGFloat
    let padding: CGFloat
    
    var label: some View {
        Text(text)
            .font(font)
            .scaledToFill()
            .padding(padding)
    }
    
    init(text: String, font: Font, gradient: LinearGradient, cornerRadius: CGFloat = 10, padding: CGFloat = 5) {
        self.text = text
        self.font = font
        self.gradient = gradient
        self.cornerRadius = cornerRadius
        self.padding = padding
    }
    
    init(text: String, font: Font, color: Color, cornerRadius: CGFloat = 10, padding: CGFloat = 5) {
        self.text = text
        self.font = font
        self.gradient = LinearGradient(
            colors: [color],
            startPoint: .leading,
            endPoint: .trailing
        )
        self.cornerRadius = cornerRadius
        self.padding = padding
    }
    
    var body: some View {
        label
            .opacity(0)
            .overlay(
                gradient
                    .inverseMask(label)
                    .cornerRadius(cornerRadius)
            )
    }
}

struct SubtractedText_Previews: PreviewProvider {
    static var previews: some View {
        SubtractedText(
            text: "Text",
            font: .body,
            gradient: .mintBlue()
        )
    }
}
