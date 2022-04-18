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
    
    func setLogo(_ logo: UIImage) {
        logoImage.image = logo
    }
    
    func setInfo(_ info: String) {
        infoLabel.text = info
    }
}
