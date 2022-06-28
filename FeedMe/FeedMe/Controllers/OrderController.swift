//
//  OrderController.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 18.04.2022.
//

import Foundation
import UIKit

class OrderController: UIViewController {
    var brandName: String = ""
    var logo: UIImage = UIImage.init(systemName: "checkmark")!
    var orderType = ""
    var date = ""
    var adress = ""
    var paymentType = ""
    var catleryAmount = ""
    var items: [Item] = []
    
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var orderTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var paymentTypeLabel: UILabel!
    @IBOutlet weak var catleryAmountLabel: UILabel!
    @IBOutlet weak var itemsStack: UIStackView!
    
    override func viewDidLoad() {
        brandNameLabel.text = brandName
        logoImage.image = logo
        orderTypeLabel.text = orderType
        dateLabel.text = date
        adressLabel.text = adress
        paymentTypeLabel.text = paymentType
        catleryAmountLabel.text = catleryAmount
        fillItemsStack()
        super.viewDidLoad()
    }
    
    func fillItemsStack() {
        for item in items {
            itemsStack.addArrangedSubview(createItemView(item: item))
        }
        itemsStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createItemView(item: Item) -> UIView {
        let backView = UIView()
        backView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        let itemName = UILabel()
        itemName.text = item.getName()
        itemName.font = .systemFont(ofSize: 17)
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemName.textColor = .white
        backView.addSubview(itemName)
        itemName.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10).isActive = true
        itemName.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        
        let itemAmount = UILabel()
        itemAmount.text = item.getAmount()
        itemAmount.translatesAutoresizingMaskIntoConstraints = false
        itemAmount.textColor = .white
        backView.addSubview(itemAmount)
        itemAmount.leadingAnchor.constraint(equalTo: itemName.trailingAnchor, constant: 10).isActive = true
        itemAmount.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
//
        let price = UILabel()
        price.text = item.getPrice()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.textColor = .systemGreen
        backView.addSubview(price)
        price.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10).isActive = true
        price.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        
        return backView
    }
}
