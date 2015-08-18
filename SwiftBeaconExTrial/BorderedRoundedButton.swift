//
//  BorderedRoundedView.swift
//  SwiftBeaconExTrial
//
//  Created by Erik Hoversten on 17.08.15.
//  Copyright (c) 2015 EverProductions. All rights reserved.
//

import UIKit

@IBDesignable
class BorderedRoundedButton: UIButton {
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
            
        }
    }
    
    @IBInspectable var borderWidth:  CGFloat = 0  {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor:  UIColor?  {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
    
}