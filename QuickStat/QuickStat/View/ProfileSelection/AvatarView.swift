//
//  AvatarView.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 09.04.2023.
//

import SwiftUI

struct AvatarView: View {
    let info: SteamProfile
    let isHighlighted: Bool
    
    let checkmarkHeight: CGFloat = SliderView.sliderHeight / 4
    
    var body: some View {
        ZStack {
            AsyncImage(url: info.avatarMedium) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ZStack {
                    Color.gray
                    
                    Text("?")
                        .font(Fonts.main.ofSize32)
                        .bold()
                }
                .opacity(0.5)
            }
            .clipShape(Circle())
            
            Circle()
                .stroke(
                    Colors.crimson,
                    lineWidth: 4
                )
                .opacity(isHighlighted ? 1 : 0)
        }
        .overlay(
            ZStack(alignment: .bottomTrailing) {
                Color.clear
                
                Circle()
                    .fill(Colors.steam.dark)
                    .frame(width: checkmarkHeight, height: checkmarkHeight)
                
                Colors.crimson
                    .mask(
                        Images.General.checkmark.circle
                            .resizable()
                            .scaledToFit()
                    )
                    .frame(width: checkmarkHeight, height: checkmarkHeight)
            }
            .opacity(isHighlighted ? 1 : 0)
        )
    }
}
