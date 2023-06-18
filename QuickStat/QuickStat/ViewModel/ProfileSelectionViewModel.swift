//
//  ProfileSelectionViewModel.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 09.04.2023.
//

import Foundation

final class ProfileSelectionViewModel: ObservableObject {
    @Published var isOnlyActiveUserShown: Bool
    @Published var selectedUser: SteamProfile?
    @Published var users: [SteamProfile]
    @Published var sliderProgress: CGFloat = 0
    @Published var isSteamLoginShown: Bool = false
    
    var userSelectorOpacity: CGFloat { 1.0 - sliderProgress }
    
    init() {
        self.isOnlyActiveUserShown = false
        self.selectedUser = nil
        if let storedUsers: [SteamProfile] = StoredSteamProfilesProvider.shared.fetchStoredData() {
            self.users = storedUsers
        } else {
            self.users = []
        }
    }
    
    var isUserLoggedIn: Bool {
        selectedUser != nil
    }
    
    func addUser(_ newUser: SteamProfile) {
        for user in users {
            if user.id == newUser.id {
                return
            }
        }
        users.append(newUser)
        StoredSteamProfilesProvider.shared.updateStoredData(with: users)
    }
}
