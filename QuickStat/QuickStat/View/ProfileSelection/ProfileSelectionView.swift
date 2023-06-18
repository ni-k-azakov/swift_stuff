//
//  ProfileSelectionView.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 08.04.2023.
//

import SwiftUI

struct ProfileSelectionView: View {
    @EnvironmentObject var viewManager: ViewManager
    @EnvironmentObject var generalDataManager: GeneralDataManager
    @StateObject private var profileSelectionViewModel = ProfileSelectionViewModel()
    
    private var isSliderEnabled: Bool {
        profileSelectionViewModel.selectedUser != nil
    }
    
    var body: some View {
        ZStack {
            Colors
                .steam
                .dark
                .hueRotation(.degrees(profileSelectionViewModel.sliderProgress * 90))
            
            VStack {
                Spacer()
                
                Images.General.logo.dota
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .onTapGesture {
                        viewManager.pop()
                    }
                
                Text("Dota.Stat")
                    .foregroundColor(.white)
                    .font(Fonts.main.ofSize50.bold())
                
                Spacer()
                
                ZStack {
                    Color.white.opacity(0.5)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            Group {
                                ForEach(profileSelectionViewModel.users, id: \.id) { user in
                                    if !profileSelectionViewModel.isOnlyActiveUserShown || profileSelectionViewModel.selectedUser?.id ?? "" == user.id {
                                        Button {
                                            profileSelectionViewModel.selectedUser = user
                                        } label: {
                                            AvatarView(
                                                info: user,
                                                isHighlighted: profileSelectionViewModel.selectedUser?.id ?? "" == user.id
                                            )
                                        }
                                    }

                                }
                                
                                Button {
                                    profileSelectionViewModel.isSteamLoginShown = true
                                } label: {
                                    ZStack {
                                        Circle()
                                            .fill(.white.opacity(0.5))
                                        
                                        Image.init(systemName: "plus")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(20)
                                            .foregroundColor(Colors.steam.dark)
                                            .hueRotation(.degrees(profileSelectionViewModel.sliderProgress * 150))
                                    }
                                }
                            }
                            .padding(.vertical, 10)
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .frame(height: SliderView.sliderHeight)
                .clipShape(RoundedRectangle(cornerRadius: SliderView.sliderHeight / 2))
                .padding(.horizontal, SliderView.horizontalPadding)
                .padding(.bottom, 10)
                .opacity(profileSelectionViewModel.userSelectorOpacity)
                
                SliderView(
                    profileSelectionViewModel: profileSelectionViewModel,
                    progress: $profileSelectionViewModel.sliderProgress,
                    onSlideEnd: {
                        guard let profile = profileSelectionViewModel.selectedUser else { return }
                        viewManager.push(
                            MatchHistoryView(
                                profileInfo: profile,
                                onPop: {
                                    profileSelectionViewModel.sliderProgress = 0
                                }
                            ).eraseToAnyView(),
                            backgroundColor: Colors.crimson
                        )
                    }
                )
                .grayscale(isSliderEnabled ? 0 : 1)
                .disabled(!isSliderEnabled)
                
                Spacer()
            }
        }
        .sheet(isPresented: $profileSelectionViewModel.isSteamLoginShown) {
            SteamProfileFinderView { user in
                profileSelectionViewModel.addUser(user)
                profileSelectionViewModel.isSteamLoginShown = false
            }
        }
    }
}

struct ProfileSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSelectionView()
    }
}
