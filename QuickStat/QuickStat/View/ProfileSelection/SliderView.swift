//
//  SliderView.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 09.04.2023.
//

import SwiftUI

struct SliderView: View {
    @ObservedObject var profileSelectionViewModel: ProfileSelectionViewModel
    @State private var avatarOffset: CGFloat = 0
    @Binding var progress: CGFloat
    let onSlideEnd: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            
            Circle()
                .fill(
                    Colors.steam.dark
                )
                .overlay(
                    ZStack {
                        Circle()
                            .fill(.white.opacity(0.9))
                        
                        Colors.steam.dark
                            .mask(
                                Images.General.logo.steam
                                .renderingMode(.template)
                                .resizable()
                                
                            )
                    }
                    .padding(5)
                )
                .offset(x: SliderView.startingPos + avatarOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            avatarOffset = min(max(value.translation.width, 0), SliderView.endPos)
                            progress = avatarOffset / SliderView.endPos
                        }
                        .onEnded { value in
                            if avatarOffset == SliderView.endPos {
                                onSlideEnd()
                            } else {
                                withAnimation(.spring()) {
                                    progress = 0
                                }
                            }
                            withAnimation(.spring()) {
                                avatarOffset = 0
                            }
                        }
                )
            
            Spacer()
        }
        .background(
            ZStack {
                Color.white.opacity(0.5)
                
                LinearGradient(
                    colors: [
                        Color.clear,
                        Colors.steam.light.opacity(0.5)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .hueRotation(.degrees(progress * 150))
                .clipShape(
                    RoundedRectangle(cornerRadius: SliderView.sliderHeight / 2)
                )
                .offset(x: SliderView.startingPos * 2 + avatarOffset)
            }
        )
        .frame(height: SliderView.sliderHeight)
        .clipShape(RoundedRectangle(cornerRadius: SliderView.sliderHeight / 2))
        .padding(.horizontal, SliderView.horizontalPadding)
    }
}

extension SliderView {
    static let horizontalPadding: CGFloat = 20
    static let sliderHeight: CGFloat = 80
    
    private static let startingPos: CGFloat = -(UIScreen.main.bounds.width - sliderHeight) / 2 + horizontalPadding
    private static let endPos: CGFloat = UIScreen.main.bounds.width - sliderHeight - horizontalPadding * 2
}
