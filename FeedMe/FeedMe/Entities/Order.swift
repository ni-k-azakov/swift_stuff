//
//  Order.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 20.04.2022.
//

import Foundation

class Order {
    private var brand: Brand
    private var adress: String
    private var date: Date
    var orderType: OrderType
    var paymentType: PaymentType
    var items: [Item]
    var catleryAmount: Int
    
    init(brand: Brand, adress: String, orderType: OrderType) {
        self.brand = brand
        self.adress = adress
        date = Date()
        self.orderType = orderType
        items = []
        paymentType = .CARD
        catleryAmount = 1
    }
    
    func setDate(_ date: Date) {
        // TODO: блок проверок
        self.date = date
    }
    
    func getDate() -> Date {
        return date
    }
    
    func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd HH:mm"
        let stringDate = formatter.string(from: date)
        return stringDate
    }
    
    func getAdress() -> String {
        return adress
    }
    
    func getBrand() -> Brand {
        return brand
    }
    
    func getString() -> String {
        return getDateString() + " " + brand.name + " (\(orderType == .SELF ? "самовывоз" : "доставка"))"
    }
    
    func getTotalSum() -> String {
        var sum = 0
        for item in items {
            sum += item.getPriceInt()
        }
        return String(sum) + "₽"
    }
    
    func hasTroubles() -> Bool {
        return false
    }
}
