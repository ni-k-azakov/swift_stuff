//
//  SteamAccountView.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 24.04.2023.
//

import SwiftUI

struct SteamAccountView: View {
    @Binding var isLoading: Bool
    @State var isLastMatchShown: Bool = false
    let profileInfo: SteamProfile
    let matchInfo: Dota.Match?
    var isClickable: Bool = false
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                AsyncImage(url: profileInfo.avatarMedium) { image in
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
                .clipShape( RoundedRectangle(cornerRadius: 10))
                .frame(width: 50, height: 50)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(profileInfo.name)
                            .font(Fonts.main.ofSize20.bold())
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        
                        Text(profileInfo.countryCode?.flagEmoji() ?? "")
                    }
                    Text(profileInfo.statusBadgeText)
                        .foregroundColor(profileInfo.statusBadgeColor)
                }
                Spacer()
                
                LinearGradient.mintBlue()
                    .hueRotation(Angle(degrees: Double(profileInfo.level ?? 0)) * 5)
                    .mask(
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 3)
                                .frame(width: 49, height: 49)
                            
                            if let level = profileInfo.level {
                                Text("\(level)")
                                    .font(Fonts.main.ofSize25)
                                    .bold()
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.1)
                                    .padding(5)
                            } else {
                                Text("?")
                                    .font(Fonts.main.ofSize32)
                                    .bold()
                            }
                        }
                        
                    )
                    .frame(width: 52, height: 52)
            }
            .opacity(isLoading ? 0 : 1)
            
//            HStack {
//                Text("Solo MMR")
//                    .font(Fonts.main.ofSize15.bold())
//
//                SubtractedText(
//                    text: "6000",
//                    font: Fonts.main.ofSize12.bold(),
//                    gradient: .mintBlue()
//                )
//                
//                Text("Party MMR")
//                    .font(Fonts.main.ofSize15.bold())
//
//                SubtractedText(
//                    text: "400",
//                    font: Fonts.main.ofSize12.bold(),
//                    gradient: .mintBlue()
//                )
//            }
//            .opacity(isLoading ? 0 : 1)
            
            if isLastMatchShown {
                MatchView(
                    matchInfo: matchInfo ?? Dota.Match.dummy(),
                    playerInfo: matchInfo?.players.first { $0.steamID32 == profileInfo.id.toSteamID32() } ?? Dota.Match.Player.dummy()
                )
                .opacity(isLoading ? 0 : 1)
            }
        }
        .padding()
        .foregroundColor(.white)
        .blur(isFramed: true)
        .overlay {
            if isLoading {
                ProgressView()
                    .tint(.white)
            }
        }
        .onTapGesture {
            guard isClickable else { return }
            withAnimation(.spring()) {
                isLastMatchShown.toggle()
            }
        }
    }
}

struct SteamAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SteamAccountView(
            isLoading: .constant(false),
            profileInfo: SteamProfile(
                from: SteamProfileDTO(
                    id: "",
                    visibility: 1,
                    state: 0,
                    name: "Господин говно",
                    commentPermission: 1,
                    profileURL: "",
                    lastLogOff: 1,
                    personaState: 1,
                    personaStateFlags: 1,
                    avatar: "",
                    avatarMedium: "",
                    avatarFull: "",
                    avatarHash: "",
                    realName: "",
                    clanID: "",
                    createdAt: 1,
                    currentGameID: "1",
                    currentGameServerIP: "",
                    currentGameTitle: "",
                    country: "",
                    stateCode: "",
                    cityID: 0
                ),
                level: 1
            ),
            matchInfo: nil
        )
    }
}
