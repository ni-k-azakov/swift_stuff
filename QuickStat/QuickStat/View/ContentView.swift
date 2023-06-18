//
//  ContentView.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 12.04.2023.
//

import SwiftUI

struct ContentView: View {
//    @State private var xOffset: CGFloat = UIScreen.main.bounds.width / 2
    @EnvironmentObject var viewManager: ViewManager
    let screenWidth = UIScreen.main.bounds.width
    
    var width: CGFloat { screenWidth * CGFloat(viewManager.screenStack.count) }
    var xOffset: CGFloat { -UIScreen.main.bounds.width / 2 * CGFloat(viewManager.screenStack.count - 1) }
    
    var body: some View {
        ZStack {
            viewManager.currentBackgound
            
            HStack(spacing: 0) {
                ForEach(viewManager.screenStack, id: \.stackPos) { screen in
                    if screen.stackPos < viewManager.screenStack.count - 2 {
                        ZStack(alignment: .top) {
                            EmptyView()
                        }
                        .frame(width: screenWidth)
                    } else {
                        ZStack(alignment: .top) {
                            screen.view
                        }
                        .frame(width: screenWidth)
                    }
                }
            }
            .frame(width: width)
            .offset(x: xOffset, y: 0)
        }
        .ignoresSafeArea()
    }
}
