//
//  UserDetailViewController+MapKit.swift
//  examenIOS
//
//  Created by Hugo Alexis Ramirez Villarreal on 14/05/25.
//

import Foundation
import CoreLocation
import MapKit


extension UserDetailViewController {
    
    func setUpMapView(){

        guard let latitude = Double(user.location.coordinates.latitude),
              let longitude = Double(user.location.coordinates.longitude) else {
            print("No se pudo convertir de string a double")
            return
        }
        
        print("latitude", latitude)
        print("longitude", longitude)

        
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let zoom = MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
        
        let region = MKCoordinateRegion(center: coordinates, span: zoom)

        mvUserLocation.setRegion(region, animated: true)
        mvUserLocation.centerCoordinate = coordinates

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = "Ubicación de \(user.name.first)"
        mvUserLocation.addAnnotation(annotation)
        
        mvUserLocation.layer.cornerRadius = 30
        
    }
    
}
