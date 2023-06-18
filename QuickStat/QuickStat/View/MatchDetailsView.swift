//
//  MatchDetailsView.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 10.06.2023.
//

import SwiftUI

struct MatchDetailsView: View {
    @ObservedObject var viewModel: MatchDetailsViewModel = MatchDetailsViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Images.General.logo.dota
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.5)
                    
                    Images.General.logo.steam
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.5)
                }
                .frame(height: 50)
                .padding(.horizontal, 20)
                
                HStack {
                    Text("Hell Raisers")
                        .font(Fonts.main.ofSize20.bold())
                        .frame(maxWidth: geometry.size.width * 0.5)
                    
                    Text("Team Spirit")
                        .font(Fonts.main.ofSize20.bold())
                        .frame(maxWidth: geometry.size.width * 0.5)
                }
                .padding(.horizontal, 20)
                
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Colors.mint.light)
                        .frame(maxWidth: geometry.size.width * 0.5)
                    
                    Rectangle()
                        .fill(Colors.crimson)
                        .frame(maxWidth: geometry.size.width * 0.5)
                }
                .frame(height: 10)
                .cornerRadius(5)
                .padding(.horizontal, 20)
                
                HStack {
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.yellow)
                            .frame(maxWidth: geometry.size.width * 0.8 / 2)
                        
                        Rectangle()
                            .fill(Colors.yellow.dark)
                            .frame(maxWidth: geometry.size.width * 0.2 / 2)
                    }
                    .frame(height: 10)
                    .cornerRadius(5)
                    .padding(.horizontal, 20)
                    
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Colors.mint.light)
                            .frame(maxWidth: geometry.size.width * 0.2 / 2)
                        
                        Rectangle()
                            .fill(Colors.mint.dark)
                            .frame(maxWidth: geometry.size.width * 0.8 / 2)
                    }
                    .frame(height: 10)
                    .cornerRadius(5)
                    .padding(.horizontal, 20)
                }
                Spacer()
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(Colors.steam.dark)
        }
    }
}

struct MatchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailsView()
    }
}
