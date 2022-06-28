//
//  RouteLineView.swift
//  WhichWay
//
//  Created by Nikita Kazakov on 10.06.2022.
//

import Foundation
import UIKit

class RouteLineView: UIView {
    private var lineWidth = 1
    private var lineColor = UIColor.black
    private var lineCornerRadius = 0
    func setLineWidth(_ width: Int) -> RouteLineView {
        lineWidth = width
        return self
    }
    
    func setLineColor(_ color: UIColor) -> RouteLineView {
        lineColor = color
        return self
    }
    
    func setLineCurve(_ radius: Int) -> RouteLineView {
        lineCornerRadius = radius
        return self
    }
    
    func drawLine() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        let containerLeft = UIView()
        containerLeft.translatesAutoresizingMaskIntoConstraints = false
        containerLeft.clipsToBounds = true
        self.addSubview(containerLeft)
        containerLeft
            .setWidthConstraint(equalTo: self.widthAnchor, multiplier: 0.5)
            .setHeightConstraint(equalTo: self.heightAnchor, constant: -10)
            .centerVertically(equalTo: self.centerYAnchor)
            .setLeadingConstraint(equalTo: self.leadingAnchor)
        
        let leftLine = UIView()
        leftLine.layer.borderColor = lineColor.cgColor
        leftLine.layer.borderWidth = CGFloat(lineWidth)
        leftLine.layer.cornerRadius = CGFloat(lineCornerRadius)
        leftLine.translatesAutoresizingMaskIntoConstraints = false
        containerLeft.addSubview(
            leftLine
        )
        leftLine
            .setWidthConstraint(equalTo: containerLeft.widthAnchor, multiplier: 2)
            .setHeightConstraint(equalTo: containerLeft.heightAnchor)
            .setLeadingConstraint(equalTo: containerLeft.leadingAnchor, constant: 20)
            .setBottomConstraint(equalTo: containerLeft.centerYAnchor, constant: CGFloat(lineWidth) / 2)
        
        let containerRight = UIView()
        containerRight.translatesAutoresizingMaskIntoConstraints = false
        containerRight.clipsToBounds = true
        self.addSubview(containerRight)
        containerRight
            .setWidthConstraint(equalTo: self.widthAnchor, multiplier: 0.5)
            .setHeightConstraint(equalTo: self.heightAnchor, constant: -10)
            .centerVertically(equalTo: self.centerYAnchor)
            .setTrailingConstraint(equalTo: self.trailingAnchor)
        
        let rightLine = UIView()
        rightLine.layer.borderColor = lineColor.cgColor
        rightLine.layer.borderWidth = CGFloat(lineWidth)
        rightLine.layer.cornerRadius = CGFloat(lineCornerRadius)
        rightLine.translatesAutoresizingMaskIntoConstraints = false
        containerRight.addSubview(
            rightLine
        )
        rightLine
            .setWidthConstraint(equalTo: containerRight.widthAnchor, multiplier: 2)
            .setHeightConstraint(equalTo: containerRight.heightAnchor)
            .setTrailingConstraint(equalTo: containerRight.trailingAnchor, constant: -20)
            .setTopConstraint(equalTo: containerRight.centerYAnchor, constant: -CGFloat(lineWidth) / 2)
    }
}


