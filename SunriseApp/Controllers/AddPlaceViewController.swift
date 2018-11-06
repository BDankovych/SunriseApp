//
//  AddPlaceViewController.swift
//  TestApp
//
//  Created by GALAHAD on 11/5/18.
//  Copyright © 2018 GALAHAD. All rights reserved.
//

import UIKit
import GooglePlaces

class AddPlaceViewController: BaseViewController {
    
    lazy var placePickerController: GMSAutocompleteViewController = {
        let placePickerController = GMSAutocompleteViewController()
        placePickerController.delegate = self
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        placePickerController.autocompleteFilter = filter
        return placePickerController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func choosePlaceByName(_ sender: Any) {
        present(placePickerController, animated: true, completion: nil)
    }
    
    
}

extension AddPlaceViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let placeModel = PlaceModel(place)
        PlacesManager.addPlace(placeModel)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        showErrorPopup(text: error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
