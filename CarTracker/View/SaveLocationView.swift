//
//  SaveLocationView.swift
//  CarTracker
//
//  Created by Mádi István on 2021. 11. 26..
//

import SwiftUI
import MapKit
import CoreLocation

struct SaveLocationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingPopover = false
    @StateObject var locationViewModel = LocationViewModel()
    @ObservedObject var firestoreManager: FirestoreManager
    
    init(firestore:FirestoreManager){
        firestoreManager = firestore
    }
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        
        
        ZStack(){
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                .edgesIgnoringSafeArea(.all)
            VStack{
                //Spacer()
                Button(action: { saveLocation() }) {
                    HStack {
                        Spacer()
                        Image(systemName: "mappin")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                        
                        
                        Spacer()
                        
                    }
                    .background(Color.green)
                    .clipShape(Circle())
                    .padding(10)
                    .frame(width:100, height: 100)
                }
                .alert("Enable location tracking in settings",isPresented: $showingPopover) {
                    Button("Ok"){
                        
                    }
                }
                .onAppear(perform: {locationViewModel.requestPermission()})
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        
        
        
    }
    func saveLocation(){
        if locationViewModel.authorizationStatus != CLAuthorizationStatus.denied{
            firestoreManager.saveLocation(locationManager: locationViewModel.locationManager)
            ButtonHelper.shared.disabled = false
        }
        else{
            showingPopover = true
        }
        self.presentationMode.wrappedValue.dismiss()
        
        
    }
    
}

struct SaveLocation_Previews: PreviewProvider {
    static var previews: some View {
        SaveLocationView(firestore: FirestoreManager())
    }
}
