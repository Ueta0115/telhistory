//
//  RealmController.swift
//  telhistory
//
//  Created by 上江田裕紀 on 2019/12/17.
//  Copyright © 2019 n1system. All rights reserved.
//

import UIKit
import RealmSwift

class RealmController: Object {
    
    @objc dynamic var Day = ""
    @objc dynamic var Time = ""
    @objc dynamic var Can_neme = ""
    @objc dynamic var Com_Menber = ""
    @objc dynamic var To_Name = ""
    @objc dynamic var Content = ""
    @objc dynamic var Recepter = ""
    @objc dynamic var Count = 0
}
