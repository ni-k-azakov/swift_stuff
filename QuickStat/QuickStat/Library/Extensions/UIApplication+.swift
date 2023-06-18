//
//  UIApplication+.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 13.04.2023.
//

import SwiftUI

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
