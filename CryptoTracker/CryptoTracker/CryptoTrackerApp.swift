//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 07..
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView()
            
            //ContentView()
              //  .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
