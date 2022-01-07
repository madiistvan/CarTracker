//
//  FireStoreManager.swift
//  CarTracker
//
//  Created by Mádi István on 2021. 11. 26..
//

import Foundation
import FirebaseFirestore
import Firebase
import MapKit

class FirestoreManager: ObservableObject{
    @Published var location: CLLocationCoordinate2D?
    let db = Firestore.firestore()
    
    func fetchLocation(){
        print("fetching location")
        
        let docRef = db.collection(Auth.auth().currentUser!.uid).document("location")
        
        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                ButtonHelper.shared.disabled = (self.location == nil)
                return
            }
            if let document = document, document.exists {
                if let coords = document.get("location") {
                    let point = coords as! GeoPoint
                    let lat = point.latitude
                    let lon = point.longitude
                    print(lat, lon)
                    self.location = CLLocationCoordinate2D(latitude: lat,longitude: lon)
                    ButtonHelper.shared.disabled = (self.location == nil)
                }
            }
        }
    }
    func deletLocation(){
        let docRef = db.collection(Auth.auth().currentUser!.uid).document("location")
        docRef.delete()
        location = nil
        ButtonHelper.shared.disabled = true
        
    }
    func saveLocation(locationManager:CLLocationManager){
        var location: CLLocation? = nil
        while(location==nil){
            location = locationManager.location
        }
        
        let docRef = db.collection(Auth.auth().currentUser!.uid).document("location")
        docRef.setData(["location": GeoPoint(latitude: location!.coordinate.latitude,longitude: location!.coordinate.longitude)])
        fetchLocation()
    }
}
