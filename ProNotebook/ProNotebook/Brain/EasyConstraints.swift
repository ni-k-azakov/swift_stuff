//
//  EasyConstraints.swift
//  WhichWay
//
//  Created by Nikita Kazakov on 10.06.2022.
//

import Foundation
import UIKit

extension UIView {
    func setWidthConstraint(equalTo: NSLayoutDimension, constant: CGFloat = 0, multiplier: CGFloat = 1) -> UIView {
        self.widthAnchor.constraint(equalTo: equalTo, multiplier: multiplier, constant: constant).isActive = true
        return self
    }
    
    func setWidthConstraint(constant: CGFloat) -> UIView {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    func setHeightConstraint(equalTo: NSLayoutDimension, constant: CGFloat = 0, multiplier: CGFloat = 1) -> UIView {
        self.heightAnchor.constraint(equalTo: equalTo, multiplier: multiplier, constant: constant).isActive = true
        return self
    }
    
    func setHeightConstraint(constant: CGFloat) -> UIView {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    func setLeadingConstraint(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> UIView {
        self.leadingAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
        return self
    }
    
    func setTrailingConstraint(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> UIView {
        self.trailingAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
        return self
    }
    
    func setTopConstraint(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> UIView {
        self.topAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
        return self
    }
    
    func setBottomConstraint(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> UIView {
        self.bottomAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
        return self
    }
    
    func centerVertically(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> UIView {
        self.centerYAnchor.constraint(equalTo: equalTo, constant: 0).isActive = true
        return self
    }
    
    func centerHorizontally(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> UIView {
        self.centerXAnchor.constraint(equalTo: equalTo, constant: 0).isActive = true
        return self
    }
}
