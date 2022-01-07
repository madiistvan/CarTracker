//
//  MainPageView.swift
//  CarTracker
//
//  Created by Mádi István on 2021. 11. 27..
//

import SwiftUI
import MapKit

struct MainPageView: View {
    @ObservedObject var firestoreManager: FirestoreManager
    @State private var selection: String? = nil
    @ObservedObject var disabled = ButtonHelper.shared
    
    init(firestoreManager: FirestoreManager){
        self.firestoreManager = firestoreManager
        firestoreManager.fetchLocation()
    }
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: SaveLocationView(firestore: firestoreManager), tag: "SaveLocationView", selection: $selection) { EmptyView() }
                NavigationLink(destination: CarLocationView(location: firestoreManager.location ?? CLLocationCoordinate2D(latitude: 0,longitude: 0)), tag: "CarLocationView", selection: $selection) { EmptyView() }
                
                Image("car")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Button(action: {self.selection = "CarLocationView"})
                {
                    HStack {
                        Spacer()
                        Text("Show me my car")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                    }
                    .background(disabled.disabled ? .gray : .green)
                    .cornerRadius(15.0)
                }.padding(.top)
                    .disabled(disabled.disabled)
                
                Button(action: {self.selection = "SaveLocationView"}) {
                    HStack {
                        Spacer()
                        Text("Save my car's location")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                    }
                    .background(.green)
                    .cornerRadius(15.0)
                }.padding(.top)
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {UserSettings.shared.loggedIn.toggle()}) {
                        Image(systemName: "return")
                        
                    }
                }
                
            }
            
        }
        .onAppear(perform: {firestoreManager.fetchLocation()
            
        })
    }
}
