//
//  SecondViewController.swift
//  TestApp
//
//  Created by GALAHAD on 11/5/18.
//  Copyright © 2018 GALAHAD. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRegognizer = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapRegognizer)
        
//        let location = CLLocation(latitude: 1.0, longitude: 1.0)
//        CLGeocoder().reverseGeocodeLocation(location) { (marks, error) in
//            print(marks?.first)
//            print(marks?.first?.name)
//            print(marks?.first?.locality)
//        }
    }
    
    @objc func handleMapTap(_ tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let tapLocation = tapRecognizer.location(in: mapView)
            let locationCoord = mapView.convert(tapLocation, toCoordinateFrom: mapView)
            let location = CLLocation(latitude: locationCoord.latitude, longitude: locationCoord.longitude)
            CLGeocoder().reverseGeocodeLocation(location) { (marks, error) in
                print(marks?.first)
                print(marks?.first?.name)
                print(marks?.first?.locality)
            }
        }
    }
    

}
