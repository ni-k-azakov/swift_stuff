//
//  UIScreen+.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 05.06.2023.
//

import UIKit

extension UIScreen {
    static var isSmallScreen: Bool {
        UIScreen.main.bounds.height <= 800
    }
}
