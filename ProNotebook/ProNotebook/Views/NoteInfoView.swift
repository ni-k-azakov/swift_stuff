//
//  NoteView.swift
//  ProNotebook
//
//  Created by Nikita Kazakov on 05.07.2022.
//

import Foundation
import UIKit

class NoteInfoView: UIView {
    private var titleLabel: UILabel!
    private var subTitleLabel: UILabel!
    private var isOpen = false
    private var capLeadingConstraint: NSLayoutConstraint!
    private var capTrailingConstraint: NSLayoutConstraint!
    var category: String!
    var color: UIColor? {
        get {
            return self.backgroundColor
        }
        set(newVal) {
            self.backgroundColor = newVal
        }
    }
    
    var title: String {
        get {
            return titleLabel.text ?? ""
        }
        set(newVal) {
            titleLabel.text = newVal
        }
    }
    
    var subTitle: String? {
        get {
            return subTitleLabel.text
        }
        set(newVal) {
            subTitleLabel.text = newVal
        }
    }
    
    var fontSize: CGFloat {
        get {
            return 1
        }
        set(newVal) {
            titleLabel.font = .systemFont(ofSize: newVal)
        }
    }
    
    var subFontSize: CGFloat {
        get {
            return 1
        }
        set(newVal) {
            subTitleLabel.font = .systemFont(ofSize: newVal)
        }
    }
    
    static func build(_ title: String, color: UIColor, category: String) -> NoteInfoView {
        let noteView = NoteInfoView()
        noteView.titleLabel = UILabel()
        noteView.subTitleLabel = UILabel()
        noteView.color = color
        noteView.category = category
        noteView.title = title
        noteView.prepare()
        return noteView
    }
    
    static func build(_ title: String, color: UIColor, category: String, subTitle: String) -> NoteInfoView {
        let noteView = NoteInfoView()
        noteView.titleLabel = UILabel()
        noteView.subTitleLabel = UILabel()
        noteView.color = color
        noteView.category = category
        
        noteView.title = title
        noteView.subTitle = subTitle
        noteView.prepare()
        return noteView
    }
    
    private func prepare() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        self.layer.cornerRadius = 15
        self.backgroundColor = color
        self.clipsToBounds = true
        
        let cap = UIView()
        cap.translatesAutoresizingMaskIntoConstraints = false
        cap.backgroundColor = UIColor.lightGray
        self.addSubview(cap)
        cap.setTopConstraint(equalTo: self.topAnchor)
            .setBottomConstraint(equalTo: self.bottomAnchor)
            .layer.cornerRadius = 15
        capLeadingConstraint = cap.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -1)
        capLeadingConstraint.isActive = true
        capTrailingConstraint = cap.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        capTrailingConstraint.isActive = true
        
        cap.addSubview(titleLabel)
        titleLabel.textAlignment = .left
        titleLabel.setLeadingConstraint(equalTo: cap.leadingAnchor, constant: 10)
            .setTrailingConstraint(equalTo: cap.trailingAnchor, constant: -10)
            .setTopConstraint(equalTo: cap.topAnchor, constant: 10)
            .translatesAutoresizingMaskIntoConstraints = false
        
        cap.addSubview(subTitleLabel)
        subTitleLabel.textAlignment = .left
        subTitleLabel.setLeadingConstraint(equalTo: cap.leadingAnchor, constant: 10)
            .setTrailingConstraint(equalTo: cap.trailingAnchor, constant: -10)
            .setTopConstraint(equalTo: titleLabel.bottomAnchor)
            .setBottomConstraint(equalTo: cap.bottomAnchor, constant: -10)
            .translatesAutoresizingMaskIntoConstraints = false
        
        let gestureHolder = UIView()
        self.addSubview(gestureHolder)
        gestureHolder.setTopConstraint(equalTo: self.topAnchor)
            .setBottomConstraint(equalTo: self.bottomAnchor)
            .setLeadingConstraint(equalTo: self.leadingAnchor)
            .setTrailingConstraint(equalTo: self.trailingAnchor)
            .translatesAutoresizingMaskIntoConstraints = false
        let recognizer = UITapGestureRecognizer()
        recognizer.numberOfTapsRequired = 2
        recognizer.addTarget(self, action: #selector(doubleTapped))
        gestureHolder.addGestureRecognizer(recognizer)
    }

    @objc func doubleTapped(recognizer: UITapGestureRecognizer!) {
        print("TAPPED")
        if isOpen {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.capLeadingConstraint.constant = -1
                self.capTrailingConstraint.constant = -5
                self.layoutIfNeeded()
            }) { finished in
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.capLeadingConstraint.constant = -self.frame.width + self.layer.cornerRadius + 4
                self.capTrailingConstraint.constant = -self.frame.width + self.layer.cornerRadius
                self.layoutIfNeeded()
            }) { finished in
            }
        }
        isOpen.toggle()
    }
}
