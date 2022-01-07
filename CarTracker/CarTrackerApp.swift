//
//  CarTrackerApp.swift
//  CarTracker
//
//  Created by Mádi István on 2021. 11. 26..
//

import SwiftUI
import Firebase


@main
struct CarTrackerApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
