//
//  SettingFormViewController.swift
//  Salon
//
//  Created by mac on 2018/8/21.
//  Copyright © 2018年 Hengyu Liu. All rights reserved.
//

import UIKit
import Eureka

class SettingFormViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Section1")
            <<< TextRow(){ row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< PhoneRow(){
                $0.title = "Phone Row"
                $0.placeholder = "And numbers here"
            }
            +++ Section("Distance")
            <<< DateRow(){
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
        }
    }
}
