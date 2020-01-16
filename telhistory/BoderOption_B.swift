//
//  BoderOption_B.swift
//  telhistory
//
//  Created by USER on 2019/10/15.
//  Copyright © 2019 n1system. All rights reserved.
//

import UIKit

class BoderOption_B: UIButton {

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}
