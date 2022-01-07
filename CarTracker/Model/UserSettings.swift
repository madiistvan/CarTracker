//
//  UserSettings.swift
//  CarTracker
//
//  Created by Mádi István on 2021. 12. 11..
//

import Foundation

class UserSettings: ObservableObject {
    static let shared = UserSettings() //SINGELTON
    @Published var loggedIn : Bool = false
}
