//
//  MatchView.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 13.04.2023.
//

import SwiftUI

struct MatchView: View {
    @EnvironmentObject var generalDataManager: GeneralDataManager
    let dateFormatterPrint = DateFormatter()
    let matchInfo: Dota.Match
    let playerInfo: Dota.Match.Player
    
    
    
    var didWin: Bool {
        matchInfo.winner == playerInfo.team
    }
    
    var statusIcon: Image {
        didWin ? Image(systemName: "arrowtriangle.up.circle.fill") : Image(systemName: "arrowtriangle.down.circle.fill")
    }
    
    var date: String {
        dateFormatterPrint.dateFormat = "dd MMM yyyy, HH:mm"
        let date = Date(timeIntervalSince1970: Double(matchInfo.startedAt))
        return dateFormatterPrint.string(from: date)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Spacer()
                
                HStack {
                    Color.white
                        .mask(
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.white, lineWidth: 2)
                                
                                
                                Text("KDA \(playerInfo.kills)/\(playerInfo.deaths)/\(playerInfo.assists)")
                                    .font(Fonts.main.ofSize12.bold())
                                    .foregroundColor(.white)
                            }
                                .frame(width: 90, height: 18)
                        )
                        .frame(width: 92, height: 20)
                        .opacity(0.7)
                    
//                    Spacer()
                    
                    Color.yellow
                        .mask(
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.white, lineWidth: 2)
                                
                                
                                Text("GPM \(playerInfo.gpm)")
                                    .font(Fonts.main.ofSize12.bold())
                                    .foregroundColor(.white)
                            }
                                .frame(width: 73, height: 18)
                        )
                        .frame(width: 75, height: 20)
                        .opacity(0.7)
                    
                    Color.cyan
                        .mask(
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.white, lineWidth: 2)
                                
                                
                                Text("XPM \(playerInfo.xpm)")
                                    .font(Fonts.main.ofSize12.bold())
                                    .foregroundColor(.white)
                            }
                                .frame(width: 73, height: 18)
                        )
                        .frame(width: 75, height: 20)
                        .opacity(0.7)
                }
                .frame(height: 30)
            }
            .frame(height: 110)
            .padding(.horizontal, 20)
            
            HStack(spacing: 20) {
                statusIcon
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(didWin ? .green : .red)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(matchInfo.gameMode.description)
                        .font(Fonts.main.ofSize17.bold())
                    
                    Text(date)
                        .font(Fonts.main.ofSize12)
                }
                
                Spacer()
                
                Color.white
                    .mask(
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.white, lineWidth: 2)
                            
                            
                            Text(matchInfo.duration.time())
                                .font(Fonts.main.ofSize12.bold())
                                .foregroundColor(.white)
                        }
                        .frame(width: 48, height: 23)
                    )
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                .black.opacity(0.5)
                            )
                            .padding(2)
                    }
                    .frame(width: 50, height: 25)
            }
            .frame(height: 80)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .background(
                ZStack {
                    HStack {
                        Spacer()
                        
                        AsyncImage(url: generalDataManager.getHero(withID: playerInfo.heroID)?.fullImageUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .mask(LinearGradient(colors: [.clear, .white], startPoint: .leading, endPoint: .trailing))
                        } placeholder: {
                            EmptyView()
                        }
                        
//                        Images.Heroes.undying
//                            .resizable()
//                            .scaledToFit()
//                            .mask(LinearGradient(colors: [.clear, .white], startPoint: .leading, endPoint: .trailing))
                    }
                }
            )
            .blur(isFramed: true)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView(
            matchInfo: Dota.Match(
                from: DotaMatchDetailsDTO(
                    players: [],
                    didRadiantWin: true,
                    duration: 1725,
                    preGameDuration: 160,
                    startedAt: 1682626174,
                    matchID: 160,
                    matchSeqNum: 160,
                    towerStatusRadiant: 160,
                    towerStatusDire: 160,
                    barracksStatusRadiant: 160,
                    barracksStatusDire: 160,
                    cluster: 160,
                    firstBloodTime: 160,
                    lobbyType: 160,
                    humanPlayers: 160,
                    leagueID: 160,
                    positiveVotes: 160,
                    negativeVotes: 160,
                    gameMode: 2,
                    flags: 160,
                    engine: 160,
                    radiantScore: 160,
                    direScore: 160,
                    picksBans: []
                )
            ),
            playerInfo: Dota.Match.Player(
                steamID32: 1,
                team: .dire,
                kills: 10,
                deaths: 2,
                assists: 5,
                gpm: 856,
                xpm: 630,
                level: 5,
                heroID: 3
            )
        )
    }
}
