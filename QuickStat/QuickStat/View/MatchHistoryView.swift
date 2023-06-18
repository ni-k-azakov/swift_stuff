//
//  MatchHistoryView.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 04.06.2023.
//

import SwiftUI

struct MatchHistoryView: View {
    @EnvironmentObject var viewManager: ViewManager
    @ObservedObject var viewModel: MatchHistoryViewModel
    @State private var backOpacity: CGFloat = 0
    private let topPadding: CGFloat = UIScreen.isSmallScreen ? 0 : 20
    private let onPop: () -> Void
    
    init(profileInfo: SteamProfile, onPop: @escaping () -> Void) {
        self.viewModel = MatchHistoryViewModel(profileInfo: profileInfo)
        self.onPop = onPop
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Colors.crimson
            
            VStack {
                Group {
                    HStack {
                        Text("Most played")
                            .font(Fonts.main.ofSize25.bold())
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        SubtractedText(
                            text: viewModel.mostPlayedGM?.0.description ?? "None",
                            font: Fonts.main.ofSize15.bold(),
                            color: .white
                        )
                        
                        SubtractedText(
                            text: String((viewModel.mostPlayedGM?.1.wins ?? 0) + (viewModel.mostPlayedGM?.1.loses ?? 0)),
                            font: Fonts.main.ofSize15.bold(),
                            color: .white
                        )
                    }
                    
                    HStack {
                        Text("Best")
                            .font(Fonts.main.ofSize25.bold())
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        SubtractedText(
                            text: viewModel.bestGM?.0.description ?? "None",
                            font: Fonts.main.ofSize15.bold(),
                            color: .white
                        )
                        
                        SubtractedText(
                            text: "\(Int((viewModel.bestGM?.1.winrate ?? 0) * 100))%",
                            font: Fonts.main.ofSize15.bold(),
                            color: .white
                        )
                    }
                }
                .padding(10)
                .blur()
                .padding(.horizontal, 20)
                
                VStack {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .font(Fonts.main.ofSize20)
                        
                        Text("All pick")
                            .font(Fonts.main.ofSize32)
                        
                        Spacer()
                        
                        SubtractedText(
                            text: "W \(viewModel.gmWinrates[.allPick]?.wins ?? 0) | L \(viewModel.gmWinrates[.allPick]?.loses ?? 0)",
                            font: Fonts.main.ofSize12.bold(),
                            color: .white,
                            cornerRadius: 10
                        )
                        
                        SubtractedText(
                            text: "\(Int((viewModel.gmWinrates[.allPick]?.winrate ?? 0) * 100))%",
                            font: Fonts.main.ofSize12.bold(),
                            color: .white,
                            cornerRadius: 10
                        )
                        
                        Image(systemName: "chevron.forward")
                            .font(Fonts.main.ofSize20)
                    }
                    .foregroundColor(.white)
                    .padding(10)
                    .background {
                        if let wins = viewModel.gmWinrates[.allPick]?.wins, let loses = viewModel.gmWinrates[.allPick]?.loses {
                            Color.score(positive: wins, negative: loses)
                                .cornerRadius(15)
                                .opacity(0.7)
                        } else {
                            Color.white.opacity(0.3)
                                .cornerRadius(15)
                        }
                    }
                    
                    HStack {
                        Color.white
                            .mask(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.white, lineWidth: 2)
                                    
                                    
                                    Text("KDA 10/0/33")
                                        .font(Fonts.main.ofSize12.bold())
                                        .foregroundColor(.white)
                                }
                                    .frame(width: 90, height: 18)
                            )
                            .frame(width: 92, height: 20)
                        
                        Color.yellow
                            .mask(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.white, lineWidth: 2)
                                    
                                    
                                    Text("GPM \(588)")
                                        .font(Fonts.main.ofSize12.bold())
                                        .foregroundColor(.white)
                                }
                                    .frame(width: 73, height: 18)
                            )
                            .frame(width: 75, height: 20)
                        
                        Color.cyan
                            .mask(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.white, lineWidth: 2)
                                    
                                    
                                    Text("XPM \(300)")
                                        .font(Fonts.main.ofSize12.bold())
                                        .foregroundColor(.white)
                                }
                                    .frame(width: 73, height: 18)
                            )
                            .frame(width: 75, height: 20)
                    }
                    
                    HStack(alignment: .bottom) {
                        WinrateView(
                            wins: viewModel.mostPlayedHeroWinrate?.wins ?? 0, loses: viewModel.mostPlayedHeroWinrate?.loses ?? 0)
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 0) {
                            HStack {
                                Spacer()
                                
                                SubtractedText(
                                    text: viewModel.mostPlayedHeroWinrate?.hero.localizedName ?? "Unknown",
                                    font: Fonts.main.ofSize17.bold(),
                                    color: .white,
                                    padding: 3
                                )
                                
                                Text("\(Int((viewModel.mostPlayedHeroWinrate?.winrate ?? 0) * 100))%")
                                    .font(Fonts.main.ofSize25.bold())
                            }
                            
                            Text("Most played hero")
                                .font(Fonts.main.ofSize20.bold())
                        }
                        .padding([.trailing, .vertical], 10)
                    }
                    .background {
                        HStack {
                            Spacer()
                            
                            AsyncImage(url: viewModel.generalDataManager.getHero(withID: viewModel.mostPlayedHeroWinrate?.hero.id ?? -1)?.fullImageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .mask(LinearGradient(colors: [.clear, .white.opacity(0.7)], startPoint: .leading, endPoint: .trailing))
                            } placeholder: {
                                EmptyView()
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    .blur()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 2)
                            .foregroundColor(Color.score(positive: viewModel.mostPlayedHeroWinrate?.wins ?? 0, negative: viewModel.mostPlayedHeroWinrate?.loses ?? 0))
                            .padding(1)
                            .mask(
                                LinearGradient(colors: [.white, .clear, .clear], startPoint: .leading, endPoint: .trailing)
                            )
                            .opacity(0.5)
                    }
                    
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("\(Int((viewModel.bestHeroWinrate?.winrate ?? 0) * 100))%")
                                    .font(Fonts.main.ofSize25.bold())
                                
                                SubtractedText(
                                    text: viewModel.bestHeroWinrate?.hero.localizedName ?? "Unknown",
                                    font: Fonts.main.ofSize17.bold(),
                                    color: .white,
                                    padding: 3
                                )
                                
                                Spacer()
                            }
                            
                            Text("Best hero")
                                .font(Fonts.main.ofSize20.bold())
                        }
                        .padding([.leading, .vertical], 10)
                        
                        Spacer()
                        
                        WinrateView(
                            wins: viewModel.bestHeroWinrate?.wins ?? 0,
                            loses: viewModel.bestHeroWinrate?.loses ?? 0
                        )
                    }
                    .background {
                        HStack {
                            AsyncImage(url: viewModel.generalDataManager.getHero(withID: viewModel.bestHeroWinrate?.hero.id ?? -1)?.fullImageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .mask(LinearGradient(colors: [.white.opacity(0.7), .clear], startPoint: .leading, endPoint: .trailing))
                            } placeholder: {
                                EmptyView()
                            }
                            
                            Spacer()
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    .blur()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 2)
                            .foregroundColor(Color.score(positive: viewModel.bestHeroWinrate?.wins ?? 0, negative: viewModel.bestHeroWinrate?.loses ?? 0))
                            .padding(1)
                            .mask(
                                LinearGradient(colors: [.clear, .clear, .white], startPoint: .leading, endPoint: .trailing)
                            )
                            .opacity(0.5)
                    }
                }
                .padding(10)
                .blur()
                .padding(.horizontal, 20)
                .foregroundColor(.white)
            }
            .padding(.top, 100 + topPadding)
            
            Colors.steam.dark
                .opacity(backOpacity)
            
            TrackableScrollView(
                axes: .vertical,
                showsIndicators: false,
                offsetChanged: { offset in
                    guard offset.y < 0 else {
                        backOpacity = 0
                        return
                    }
                    let maxOffset: CGFloat = 150
                    backOpacity = max(0, min(abs(offset.y), maxOffset)) / maxOffset
                },
                content: {
                    VStack {
                        Text("Match history")
                            .foregroundColor(
                                .white.opacity(backOpacity)
                            )
                            .font(Fonts.main.ofSize32.bold())
                        
                        ZStack {
                            Colors.steam.dark
                                .cornerRadius(15)
                            
                            VStack {
                                if viewModel.matches.isEmpty {
                                    ForEach(0..<100) { _ in
                                        Button {
                                            
                                        } label: {
                                            MatchView(
                                                matchInfo: Dota.Match.dummy(),
                                                playerInfo:  Dota.Match.Player.dummy()
                                            )
                                        }
                                    }
                                } else {
                                    ForEach(viewModel.matches, id: \.matchID) { matchDTO in
                                        let matchInfo = Dota.Match(from: matchDTO)
                                        Button {
                                            
                                        } label: {
                                            MatchView(
                                                matchInfo: matchInfo,
                                                playerInfo: matchInfo.players.first { $0.steamID32 == viewModel.profileInfo.id.toSteamID32() } ?? Dota.Match.Player.dummy()
                                            )
                                        }
                                    }
                                }
                            }
                            .padding(20)
                            .blur(isFramed: true)
                        }
                    }
                    .padding(.top, UIScreen.main.bounds.height - 200)
                }
            )
            
            ZStack {
                HStack {
                    Button {
                        pop()
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "chevron.backward")
                                .font(Fonts.main.ofSize25.bold())
                                .foregroundColor(
                                    Color(white: backOpacity)
                                )
                            
                            
                            ZStack {
                                AsyncImage(url: viewModel.profileInfo.avatarMedium) { image in
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
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(Color(white: backOpacity))
                            }
                            .frame(width: 40, height: 40)
                            
                            Text(viewModel.profileInfo.name)
                                .font(Fonts.main.ofSize25.bold())
                                .foregroundColor(
                                    Color(white: backOpacity)
                                )
                        }
                    }
                    
                    Spacer()
                    
                    Text(viewModel.profileInfo.state.text)
                        .font(Fonts.main.ofSize17)
                        .foregroundColor(viewModel.profileInfo.state.color)
                }
                .padding(.top, 40 + topPadding)
                .padding([.horizontal, .bottom], 20)
            }
            .background(
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                    }
                }
                .blur(0)
                .opacity(backOpacity)
            )
        }
    }
    
    func pop() {
        onPop()
        viewManager.pop()
    }
}

struct MatchHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        MatchHistoryView(profileInfo: .dummy(), onPop: {})
    }
}
