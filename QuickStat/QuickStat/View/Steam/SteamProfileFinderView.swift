//
//  SteamProfileFinderView.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 13.04.2023.
//

import SwiftUI

struct SteamProfileFinderView: View {
    @StateObject private var steamProfileFinderViewModel = SteamProfileFinderViewModel()
    var onSelect: ((SteamProfile) -> Void)?
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Colors.steam.dark, Colors.steam.light], startPoint: .top, endPoint: .bottom)
            
            VStack {
                Text("Enter SteamID64 or trade link")
                    .font(Fonts.main.ofSize32.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
                
                TextField("", text: $steamProfileFinderViewModel.userToFind)
                    .textInputAutocapitalization(.never)
                    .font(Fonts.main.ofSize25.bold())
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 8)
                    )
                    .overlay(
                        HStack {
                            Spacer()
                            
                            Button {
                                Task {
                                    await steamProfileFinderViewModel.findUser()
                                }
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .bold()
                                    .foregroundColor(Colors.steam.dark)
                                    .scaledToFit()
                                    .padding(12)
                                    .background(Color.white)
                            }
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical, 25)
                
                if let profile = steamProfileFinderViewModel.profile {
                    SteamAccountView(
                        isLoading: $steamProfileFinderViewModel.isLoading,
                        isLastMatchShown: true,
                        profileInfo: profile,
                        matchInfo: steamProfileFinderViewModel.lastMatch
                    )
                }
                
                Spacer()
                
                if let profile = steamProfileFinderViewModel.profile, !steamProfileFinderViewModel.isLoading {
                    Button {
                        onSelect?(profile)
                    } label: {
                        Text("Select")
                            .font(Fonts.main.ofSize20.bold())
                            .foregroundColor(Colors.steam.light)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(.white)
                            .cornerRadius(10)
                            .padding(.bottom, 50)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .foregroundColor(.white)
        .ignoresSafeArea()
    }
}

struct SteamProfileFinderView_Previews: PreviewProvider {
    static var previews: some View {
        SteamProfileFinderView()
    }
}
