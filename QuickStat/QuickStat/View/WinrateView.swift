//
//  WinrateView.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 04.06.2023.
//

import SwiftUI

struct WinrateView: View {
    let wins: Int
    let loses: Int
    
    var body: some View {
        HStack {
            VStack {
                Text("W")
                    .font(Fonts.main.ofSize25.bold())
                
                Text("\(wins)")
                    .font(Fonts.main.ofSize20)
            }
            
            VStack {
                Text("L")
                    .font(Fonts.main.ofSize25.bold())
                
                Text("\(loses)")
                    .font(Fonts.main.ofSize20)
            }
        }
        .foregroundColor(Color.score(positive: wins, negative: loses))
        .padding(10)
//        .blur()
    }
}

struct WinrateView_Previews: PreviewProvider {
    static var previews: some View {
        WinrateView(
            wins: 3,
            loses: 1
        )
    }
}
