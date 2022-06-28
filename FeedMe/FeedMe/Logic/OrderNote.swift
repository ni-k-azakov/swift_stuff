//
//  OrderNote.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 17.04.2022.
//

import Foundation

class OrderNote {
    private var product: String
    private var amount: Int
    private var price: Int
    
    init(product: String, amount: Int, price: Int) {
        self.product = product
        self.amount = amount
        self.price = price
    }
    
    func getProduct() -> String {
        return product
    }
    
    func getAmount() -> String {
        return "×\(amount)"
    }
    
    func getPrice() -> String {
        return "\(price * amount)₽"
    }
}
