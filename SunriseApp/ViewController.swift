import UIKit
import GooglePlaces

class ViewController: UIViewController {
    
    @IBOutlet weak var placesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesTableView.register(cellType: PlaceTableViewCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        placesTableView.reloadData()
    }
    
    
    @IBAction func editTablePressed(_ sender: Any) {
        placesTableView.isEditing.toggle()
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
    
//    @IBAction func autocompleteClicked(_ sender: UIButton) {
//
//        let placePickerController = GMSAutocompleteViewController()
//        placePickerController.delegate = self
//        let filter = GMSAutocompleteFilter()
//        filter.type = .city
//        placePickerController.autocompleteFilter = filter
//        present(placePickerController, animated: true, completion: nil)
//    }

//extension ViewController: GMSAutocompleteViewControllerDelegate {
//    
//    // Handle the user's selection.
//    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//        print("Place name: \(place.name)")
//        print("Place address: \(place.formattedAddress)")
//        place.coordinate
//        print("Place attributions: \(place.attributions)")
//        dismiss(animated: true, completion: nil)
//    }
//    
//    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
//        // TODO: handle the error.
//        print("Error: ", error.localizedDescription)
//    }
//    
//    // User canceled the operation.
//    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
//        dismiss(animated: true, completion: nil)
//    }
//    
//    // Turn the network activity indicator on and off again.
//    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//    }
//    
//    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//    }
//    
//}
