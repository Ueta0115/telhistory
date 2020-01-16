//
//  CheckMark.swift
//  telhistory
//
//  Created by USER on 2019/10/07.
//  Copyright © 2019 n1system. All rights reserved.
//

import UIKit

class CheckMark: UIButton {

   //var CheckImage=[UIImage(named:"CheckOFF"),UIImage(named:"CheckON")]
    
    let CheckON = UIImage(named: "CheckON.png")! as UIImage
    let CheckOFF = UIImage(named: "CheckOFF.png")! as UIImage

    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(CheckON, for:UIControl.State.normal)
            }else{
                self.setImage(CheckOFF, for:UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonaction(sender:)), for: UIControl.Event.touchUpInside)
            self.isChecked = false
        }

    @objc func buttonaction(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
    
    
    
}

   
