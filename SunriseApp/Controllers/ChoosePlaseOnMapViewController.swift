//
//  ChoosePlaseOnMapViewController.swift
//  TestApp
//
//  Created by GALAHAD on 11/5/18.
//  Copyright © 2018 GALAHAD. All rights reserved.
//

import UIKit
import MapKit

class ChoosePlaseOnMapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mapView.addGestureRecognizer(tapRecognizer)
    }

    @objc func handleTap(_ tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let tapLocation = tapRecognizer.location(in: mapView)
            let locationCoord = mapView.convert(tapLocation, toCoordinateFrom: mapView)
            let location = CLLocation(latitude: locationCoord.latitude, longitude: locationCoord.longitude)
            CLGeocoder().reverseGeocodeLocation(location) { (marks, error) in
                guard let place = marks?.first else {
                    return
                }
                self.showConfirmPopUp(for: place)
            }
        }
    }
    
    func showConfirmPopUp(for place: CLPlacemark) {
        guard let confirmVC = storyboard?.instantiateViewController(withIdentifier: ConfirmMapPlaceViewController.identifier) as? ConfirmMapPlaceViewController else {
            return
        }
        confirmVC.modalPresentationStyle = .overCurrentContext
        confirmVC.modalTransitionStyle = .crossDissolve
        present(confirmVC, animated: true)
    }

}
