//
//  UIStarView.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 22.05.2022.
//

import Foundation
import UIKit

class UIStarView: UIView {
    private var level: Int = 0
    private var maxLevel: Int = 5
    private var color: UIColor = UIColor.white
    private var icon: UIImage = UIImage.init(systemName: "star.fill")!
    private var starStack: UIStackView = UIStackView()
    
    func setupView() {
        self.backgroundColor = .clear
        starStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(starStack)
        
        starStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        starStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        starStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        starStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        updateView()
    }
    
    func setHeight(_ newHeight: CGFloat) {
        starStack.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
        updateView()
    }
    
    func setLevel(_ level: Int) {
        self.level = level
        updateView()
    }
    
    func setMaxLevel(_ level: Int) {
        self.maxLevel = level
        updateView()
    }
    
    func setColor(_ color: UIColor) {
        self.color = color
        updateView()
    }
    
    private func updateView() {
        starStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for i in 0..<maxLevel {
            let star = UIImageView()
            star.translatesAutoresizingMaskIntoConstraints = false
            star.image = icon
            star.tintColor = i < level ? color : color.withAlphaComponent(0.5)
            starStack.addArrangedSubview(star)
            star.widthAnchor.constraint(equalTo: starStack.heightAnchor).isActive = true
        }
    }
}
