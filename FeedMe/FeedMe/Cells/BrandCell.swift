//
//  BrandCell.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 28.04.2022.
//

import Foundation
import UIKit

class BrandCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UIStarView!
    
    
    func setInfo(name: String, rating: Int) {
        self.name.text = name
        self.rating.setupView()
        self.rating.setColor(UIColor.init(named: "green_accent") ?? UIColor.white)
        self.rating.setLevel(rating)
        self.rating.setHeight(15.0)
    }
}
