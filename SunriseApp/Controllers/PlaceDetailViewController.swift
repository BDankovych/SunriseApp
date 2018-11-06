//
//  PlaceDetailViewController.swift
//  SunriseApp
//
//  Created by Bohdan Dankovych on 11/6/18.
//  Copyright © 2018 Bohdan Dankovych. All rights reserved.
//

import UIKit

class PlaceDetailViewController: BaseViewController {

    static let identifier = "PlaceDetailViewControllerID"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var contentView: RoundedView!
    
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    @IBOutlet weak var sunsetTimeLabel: UILabel!
    @IBOutlet weak var dayLengthLabel: UILabel!
    
    var place: PlaceModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.isHidden = true
        configure()
    }
    
    
    func configure() {
        startActivityIndicator()
        SunriseApiManager.loadInfo(for: place) { (success, dto, errors) in
            self.stopActivityIndicator()
            if success {
                self.contentView.isHidden = false
                self.configureView(with: self.place)
                self.configureView(with: dto!)
            } else {
                self.showErrorPopup(text: errors?.localizedDescription ?? "Undefined error", completion: {
                    self.dismiss(animated: true)
                })
            }
        }
    }
    
    private func configureView(with place: PlaceModel) {
        nameLabel.text = place.name
        subTitleLabel.text = place.address
    }
    
    private func configureView(with dto: PlaceDetailModelDTO) {
        sunriseTimeLabel.text = dto.sunriseTime
        sunsetTimeLabel.text = dto.sunsetTime
        dayLengthLabel.text = dto.dayLength
    }

}
