//
//  ContentView.swift
//  Medilife
//
//  Created by Nikita Kazakov on 06.06.2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var discountsViewModel = DiscountsViewModel()
    var body: some View {
        // MARK: - Nav
        NavigationView {
            // MARK: - Scroll
            ScrollView {
                VStack(alignment: .leading) {
                    // MARK: - Greeting
                    Text("Здравствуйте,")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .padding(.bottom, -5)
                        .padding(.leading)
                        .padding(.trailing)
                    NavigationLink(destination: ProfileView()) {
                        HStack {
                            Text("Елена")
                                .font(.title2)
                                .fontWeight(.bold)
                            Image(systemName: "chevron.right")
                                .font(.body)
                        }
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                        .background(Color.accentColor)
                        .clipShape(Capsule())
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    // MARK: /Greeting -
                    // MARK: - Records
                    VStack(spacing: .zero) {
                        NavigationLink(
                            destination: RecordListView()
                                .navigationTitle("Записи")
                        ) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Записи")
                                        .fontWeight(.bold)
                                        .font(.title3)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.title3)
                                }
                                Text("18:40")
                                Text("Косметология")
                            }
                            .frame(
                                alignment: .topLeading
                            )
                            .padding()
                            .background(Color.altAccentColor)
                        }
                        .foregroundColor(Color.white)
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "square.and.pencil")
                                Text("Записаться на прием")
                            }
                        }
                        .foregroundColor(Color.white)
                        .padding(10)
                        .frame(
                            maxWidth: .infinity
                        )
                        .background(Color.accentColor)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.leading)
                    .padding(.trailing)
                    // MARK: /Records -
                    // MARK: - Services
                    Text("Услуги")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.leading)
                        .padding(.top)
                        .foregroundColor(.black)
                    // MARK: - Scroll
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(0..<6) { _ in
                                VStack {
                                    Image(systemName: "person.circle")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .aspectRatio(contentMode: .fit)
                                    Text("Косметология")
                                        .font(.caption)
                                }
                                .frame(
                                    width: 90,
                                    height: 90
                                )
                                .padding(5)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                        }
                        .padding(.leading)
                        .padding(.trailing)
                    }
                    .foregroundColor(Color.accentColor)
                    // MARK: /Scroll -
                    // MARK: /Services -
                    // MARK: - Discounts
                    Text("Акции")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.leading)
                        .padding(.top)
                        .foregroundColor(.black)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<6) { i in
                                Button(action: {}) {
                                    Text("Косметология")
                                        .font(.caption)
                                }
                                .padding(7)
                                .background(i == 1 ? Color.accentColor : Color.white)
                                .foregroundColor(i == 1 ? Color.white : Color.accentColor)
                                .clipShape(Capsule())
                            }
                        }
                        .padding(.leading)
                        .padding(.trailing)
                    }
                    if discountsViewModel.response.error {
                        let _ = print("Get discounts from API: ERROR | \(discountsViewModel.response.message)")
                    } else {
                        let _ = print("Get discounts from API: SUCCESS | \(discountsViewModel.response.message)")
                    }
                    DiscountListView(response: discountsViewModel.response)
                        .padding(.leading)
                        .padding(.trailing)
                    // MARK: /Discounts -
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .topLeading
                )
            }
            .navigationTitle("Главная")
            .navigationBarTitleDisplayMode(.inline)
            .background(LinearGradient(colors: [Color.white, Color(white: 0.9)], startPoint: .top, endPoint: .bottom))
            // MARK: /Scroll -
        }
        // MARK: /Nav -
    }
}

extension Color {
    static let altAccentColor = Color("AltAccentColor")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
