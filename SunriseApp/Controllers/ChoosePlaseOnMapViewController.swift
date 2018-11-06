//
//  ChoosePlaseOnMapViewController.swift
//  TestApp
//
//  Created by GALAHAD on 11/5/18.
//  Copyright © 2018 GALAHAD. All rights reserved.
//

import UIKit
import MapKit

class ChoosePlaseOnMapViewController: BaseViewController {

    
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
            showConfirmPopUp(for: location)
        }
    }
    
    func showConfirmPopUp(for location: CLLocation) {
        guard let confirmVC = storyboard?.instantiateViewController(withIdentifier: ConfirmMapPlaceViewController.identifier) as? ConfirmMapPlaceViewController else {
            showErrorPopup(text: "Error")
            return
        }
        confirmVC.modalPresentationStyle = .overCurrentContext
        confirmVC.modalTransitionStyle = .crossDissolve
        confirmVC.location = location
        present(confirmVC, animated: true)
    }

}
