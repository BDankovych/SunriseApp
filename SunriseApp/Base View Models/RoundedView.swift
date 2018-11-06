//
//  RoundedView.swift
//  SunriseApp
//
//  Created by Bohdan Dankovych on 11/6/18.
//  Copyright © 2018 Bohdan Dankovych. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView: UIView {
    
    @IBInspectable var cornerScale: CGFloat = 2 {
        didSet {
            setupUI()
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            setupUI()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black
    
    func setupUI() {
        clipsToBounds = true
        layer.borderWidth = borderWidth
        layer.cornerRadius = self.bounds.height / cornerScale
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / cornerScale
    }
    
}
