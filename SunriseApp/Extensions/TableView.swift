//
//  TableView.swift
//  TestApp
//
//  Created by GALAHAD on 11/5/18.
//  Copyright © 2018 GALAHAD. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(cellType: T.Type, nibName: String? = nil, customIdentifier: String? = nil) {
        let identifier = customIdentifier ?? "\(cellType)"
        let cellnibName = nibName ?? "\(cellType)"
        let nib = UINib(nibName: cellnibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func cell<T: UITableViewCell>(cellType: T.Type, nibName: String? = nil, identifier: String? = nil) -> T {
        let identifier = identifier ?? "\(cellType)"
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? T else {
            print("cell own type")
            return T.loadViewFromNib() ?? T()
        }
        
        return cell
    }
    
    
}
