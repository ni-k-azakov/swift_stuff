//
//  Schedule.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 17.04.2022.
//

import Foundation
import UIKit

class ScheduleNote {
    private var logo: UIImage
    private var date: String
    private var name: String
    private var type: OrderType
    
    init(logo: UIImage, date: String, name: String, type: OrderType) {
        self.logo = logo
        self.date = date
        self.name = name
        self.type = type
    }
    
    func getLogo() -> UIImage {
        return logo
    }
    
    func getString() -> String {
        return date + " " + name + " (\(type == .SELF ? "самовывоз" : "доставка"))"
    }
}
