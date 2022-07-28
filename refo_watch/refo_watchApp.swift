//
//  refo_watchApp.swift
//  refo_watch
//
//  Created by Bryan Kenneth on 23/07/22.
//

import SwiftUI

@main
struct refo_watchApp: App {
   
    let persistentContainer = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
                    .environment(\.managedObjectContext, persistentContainer.container.viewContext)
            }
        }
    }
}
