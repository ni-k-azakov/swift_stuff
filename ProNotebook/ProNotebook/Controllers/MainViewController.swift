//
//  ViewController.swift
//  ProNotebook
//
//  Created by Nikita Kazakov on 05.07.2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = NoteInfoView.build("TEST", color: UIColor.orange, category: "TEST CAT", subTitle: "Какое-то уточнение")
        self.view.addSubview(view)
        view.setWidthConstraint(constant: 300)
            .centerVertically(equalTo: self.view.centerYAnchor)
            .centerHorizontally(equalTo: self.view.centerXAnchor)
            .translatesAutoresizingMaskIntoConstraints = false
        view.fontSize = 20
        view.subFontSize = 10
    }


}

