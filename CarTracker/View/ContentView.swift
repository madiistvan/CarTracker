//
//  ContentView.swift
//  CarTracker
//
//  Created by Mádi István on 2021. 11. 26..
//

import SwiftUI
import Firebase
import MapKit

struct ContentView: View {
    @State private var selection: String? = nil
    
    @ObservedObject var settings = UserSettings.shared
    
    @State private var state = 0
    
    
    var firestoreManager: FirestoreManager
    
    init(){
        firestoreManager = FirestoreManager()
    }
    var body: some View {
        if settings.loggedIn{
            return AnyView(MainPageView(firestoreManager: firestoreManager))
        }
        else{
            return AnyView( LoginUIView())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
