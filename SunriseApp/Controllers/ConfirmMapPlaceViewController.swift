//
//  ConfirmMapPlaceViewController.swift
//  TestApp
//
//  Created by GALAHAD on 11/5/18.
//  Copyright © 2018 GALAHAD. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ConfirmMapPlaceViewController: BaseViewController {

    static let identifier = "ConfirmMapPlaceViewControllerID"
    
    var location: CLLocation!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var confirmView: UIView!
    
    private var placeModel: PlaceModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startActivityIndicator()
        confirmView.isHidden = true
        CLGeocoder().reverseGeocodeLocation(location) { (marks, error) in
            self.stopActivityIndicator()
            guard error == nil,
                let placeMark = marks?.first,
                let placeModel = PlaceModel(placeMark)
            else {
                self.showErrorPopup(text: error?.localizedDescription ?? "Error") {
                    self.dismiss(animated: true)
                }
                return
            }
            self.confirmView.isHidden = false
            self.configure(placeModel)
        }
    }
    
    func configure(_ placeModel: PlaceModel) {
        nameLabel.text = placeModel.name
        addressLabel.text = placeModel.address
        
        self.placeModel = placeModel
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func confirmPressed(_ sender: Any) {
        PlacesManager.addPlace(placeModel)
        dismiss(animated: true)
    }
    
    
    
}
