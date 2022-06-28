//
//  ScheduleCell.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 17.04.2022.
//

import Foundation
import UIKit

class ScheduleCell: UITableViewCell {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var troubleMark: UIImageView!
    func setLogo(_ logo: UIImage) {
        logoImage.image = logo
    }
    
    func setInfo(_ info: String) {
        infoLabel.text = info
    }
    
    func enableTrouble() {
        troubleMark.isHidden = false
    }
    
    func disableTrouble() {
        troubleMark.isHidden = true
    }
}
