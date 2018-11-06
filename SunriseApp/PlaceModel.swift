//
//  PlaceModelDTO.swift
//  TestApp
//
//  Created by GALAHAD on 11/5/18.
//  Copyright © 2018 GALAHAD. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces
import MapKit

class PlaceModel {
    
    var name: String!
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    var address: String!
    
    init() {}
    
    convenience init(_ place: GMSPlace) {
        self.init()
        name = place.name
        latitude = place.coordinate.latitude
        longitude = place.coordinate.longitude
        address = place.formattedAddress
    }
    
    convenience init?(_ place: CLPlacemark) {
        self.init()
        guard let name = place.name,
            let latitude = place.location?.coordinate.latitude,
            let longitude = place.location?.coordinate.longitude
        else {
            return nil
        }
        
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
//        self.address = address
        
    }

}
