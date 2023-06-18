//
//  QuickStatApp.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 08.04.2023.
//

import SwiftUI

@main
struct QuickStatApp: App {
    var viewManager: ViewManager
    var generalDataManager: GeneralDataManager
    
    init() {
        viewManager = ViewManager()
        viewManager.push(
            ProfileSelectionView().eraseToAnyView(),
            backgroundColor: Colors.crimson
        )
        generalDataManager = GeneralDataManager()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewManager)
                .environmentObject(generalDataManager)
        }
    }
}
