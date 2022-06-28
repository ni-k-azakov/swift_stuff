//
//  Item.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 20.04.2022.
//

import Foundation

class Item {
    private var name: String
    private var amount: Int
    private var price: Int
    
    init(name: String, amount: Int, price: Int) {
        self.name = name
        self.amount = amount
        self.price = price
    }
    
    func getName() -> String {
        return name
    }
    
    func getAmount() -> String {
        return "×\(amount)"
    }
    
    func getPrice() -> String {
        return "\(price * amount)₽"
    }
    
    func getPriceInt() -> Int {
        return price * amount
    }
}
