//
//  MainView.swift
//  CarTracker
//
//  Created by Mádi István on 2021. 11. 26..
//

import SwiftUI
import MapKit
import CoreLocation

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}
struct CarLocationView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var locationViewModel = LocationViewModel()
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0,longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @ObservedObject var firestoreManager = FirestoreManager()
    
    var place: IdentifiablePlace
    init(location :CLLocationCoordinate2D){
        place = IdentifiablePlace(lat:location.latitude,long:location.longitude)
        firestoreManager.fetchLocation()
    }
    
    var body: some View {
        
        ZStack(){
            Map(coordinateRegion: $region, showsUserLocation: true,annotationItems: [place]){
                place in MapMarker(coordinate: place.location,
                                   tint: Color.purple)
                
                
            }.edgesIgnoringSafeArea(.all)
            VStack(){
                Spacer()
                Button(action: { done() }) {
                    HStack {
                        Spacer()
                        Text("Done")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                        
                    }
                    .background(Color.green)
                    .cornerRadius(15.0)
                    
                }
                .onAppear(perform: {
                    locationViewModel.requestPermission()
                    region = MKCoordinateRegion(center: place.location, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                })
            }
        }
    }
    func done(){
        firestoreManager.deletLocation()
        self.presentationMode.wrappedValue.dismiss()
        
        
    }
    
}
