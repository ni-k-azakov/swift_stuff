//
//  ViewManager.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 13.04.2023.
//

import SwiftUI

final class ViewManager: ObservableObject {
    typealias Screen = (stackPos: Int, view: AnyView, backgroundColor: Color)
    
    @Published var screenStack: [Screen] = []
    
    var currentBackgound: Color {
        screenStack.last?.backgroundColor ?? .clear
    }
    
    var prev: AnyView? {
        let prevIndex = screenStack.count - 2
        guard prevIndex >= 0 else { return nil }
        return screenStack[prevIndex].view
    }
    
    func push(_ view: AnyView, backgroundColor: Color = .clear) {
        UIApplication.shared.hideKeyboard()
        
        withAnimation(.easeInOut) {
            screenStack.append(
                (stackPos: screenStack.count, view: view, backgroundColor: backgroundColor)
            )
        }
    }
    
    func pop() {
        guard screenStack.count > 1 else { return }
        withAnimation(.easeInOut) {
            screenStack.removeLast()
        }
    }
}
