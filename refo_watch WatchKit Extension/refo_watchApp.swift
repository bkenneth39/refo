//
//  refo_watchApp.swift
//  refo_watch WatchKit Extension
//
//  Created by Bryan Kenneth on 23/07/22.
//

import SwiftUI

@main
struct refo_watchApp: App {
    
   

    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
