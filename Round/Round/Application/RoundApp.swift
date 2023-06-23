//
//  RoundApp.swift
//  Round
//
//  Created by Nikita Kazakov on 23.06.2023.
//

import SwiftUI
import SpriteKit

@main
struct RoundApp: App {
    @State var money: Double = 0
    @State var trophey: Double = 0
    
    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .top) {
                GameView()
                    .bind(onMoneyChange: { money = $0 }, onCurrentRunChange: { trophey = $0 }) 
                    .ignoresSafeArea()
                
                TopBarView(money: $money, trophey: $trophey)
                    .blur(.systemUltraThinMaterialDark)
                    .padding(20)
                    .foregroundColor(.white)
            }
        }
    }
}

