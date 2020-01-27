//
//  CheckMark.swift
//  telhistory
//
//  Created by USER on 2019/10/07.
//  Copyright © 2019 n1system. All rights reserved.
//

import UIKit

class CheckMark: UIButton {

    let CheckImage=[UIImage(named:"CheckON.png"),UIImage(named:"CheckOFF.png")]

    var isChecked: Bool = false
    {
        didSet
        {
            if isChecked == true
            {
                self.setImage(CheckImage[1], for:UIControl.State.normal)
            }
            else
            {
                self.setImage(CheckImage[0], for:UIControl.State.normal)
            }
        }
    }
    override func awakeFromNib()
    {
        self.addTarget(self, action:#selector(buttonaction(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    @objc func buttonaction(sender: UIButton)
    {
        if sender == self
        {
            isChecked = !isChecked
        }
    }
}

   
