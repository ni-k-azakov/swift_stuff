//
//  TopBarView.swift
//  Round
//
//  Created by Nikita Kazakov on 23.06.2023.
//

import SwiftUI

struct TopBarView: View {
    @Binding var money: Double
    @Binding var trophey: Double
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("Money: \(Int(money))")
            
            Spacer()
            
            Text("Current run: \(Int(trophey))")
            
            Spacer()
        }
        .padding(20)
    }
}
