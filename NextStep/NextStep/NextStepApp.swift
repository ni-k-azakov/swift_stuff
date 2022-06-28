//
//  NextStepApp.swift
//  NextStep
//
//  Created by Nikita Kazakov on 30.05.2022.
//

import SwiftUI

@main
struct NextStepApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
