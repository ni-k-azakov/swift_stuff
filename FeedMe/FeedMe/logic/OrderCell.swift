//
//  OrderCell.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 17.04.2022.
//

import Foundation
import UIKit

class OrderCell: UITableViewCell {
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setInfo(product: String, amount: String, price: String) {
        productLabel.text = product
        amountLabel.text = amount
        priceLabel.text = price
    }
}
