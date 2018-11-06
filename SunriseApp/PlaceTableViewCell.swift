//
//  LocationTableViewCell.swift
//  TestApp
//
//  Created by GALAHAD on 11/5/18.
//  Copyright © 2018 GALAHAD. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with place: PlaceModel) {
        nameLabel.text = place.name
        subTitleLabel.text = place.address
        
        
        layer.cornerRadius = bounds.height / 2
        
    }
    
    
    
    
}
