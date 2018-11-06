//
//  PlacesManager.swift
//  SunriseApp
//
//  Created by Bohdan Dankovych on 11/6/18.
//  Copyright © 2018 Bohdan Dankovych. All rights reserved.
//

import UIKit

protocol PlacesManagerDelegate {
    func placesListChanged(_ list: [PlaceModel])
}

class PlacesManager {
    
    private static let shared = PlacesManager()
    private var delegate: PlacesManagerDelegate?
    
    var places = [PlaceModel]() {
        didSet {
            delegate?.placesListChanged(places)
        }
    }
    
    private init() {
        
    }
    
    static func setDelegate(_ delegate: PlacesManagerDelegate) {
        shared.delegate = delegate
    }
    
    static func addPlace(_ placeModel: PlaceModel) {
        shared.places.append(placeModel)
    }

    static func getPlaces() -> [PlaceModel] {
        return shared.places
    }
}
