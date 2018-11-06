import UIKit
import GooglePlaces

class ViewController: BaseViewController {
    
    @IBOutlet weak var placesTableView: UITableView!
    
    var places = [PlaceModel]()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlacesManager.setDelegate(self)
        self.placesTableView.dataSource = self
        self.placesTableView.delegate = self
        
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        
        
    }
    
    func currentLocationAllowed() {
        self.startActivityIndicator()
        self.getCurrentPlace { (placeModel, error) in
            if let error = error {
                self.showErrorPopup(text: error.localizedDescription)
            } else {
                PlacesManager.addPlace(placeModel!)
                self.placesTableView.reloadData()
            }
            self.stopActivityIndicator()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        placesTableView.reloadData()
        
    }
    
    
    @IBAction func editTablePressed(_ sender: Any) {
        placesTableView.isEditing.toggle()
    }
    
    func getCurrentPlace(_ completion:@escaping (PlaceModel?, Error?) -> Void ) {
        let placeClient = GMSPlacesClient()
        placeClient.currentPlace { (placeList, error) in
            guard let place = placeList?.likelihoods.first?.place, error == nil else {
                completion(nil, error)
                return
            }
            let placeModel = PlaceModel(place)
            placeModel.name = "Current location"
            completion(placeModel, nil)
        }
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.cell(cellType: PlaceTableViewCell.self)
        cell.configure(with: places[indexPath.section])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: PlaceDetailViewController.identifier) as? PlaceDetailViewController {
//            self.navigationController!.present(detailVC, animated: true) {
//                detailVC.configure(with: self.places[indexPath.section])
//            }
            detailVC.place = self.places[indexPath.section]
            self.navigationController!.show(detailVC, sender: nil)
        }
    }
    
}


extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            currentLocationAllowed()
            break
        default:
            manager.requestWhenInUseAuthorization()
        }
    }
}


extension ViewController: PlacesManagerDelegate {
    func placesListChanged(_ list: [PlaceModel]) {
        places = list
    }
}
