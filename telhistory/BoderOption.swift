//
//  BoderOption.swift
//  telhistory
//
//  Created by USER on 2019/10/15.
//  Copyright © 2019 n1system. All rights reserved.
//

import UIKit

class BoderOption: UITextView {
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}

