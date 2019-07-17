//
//  NewDealViewController.swift
//  SalonMerchant
//
//  Created by 刘恒宇 on 2018/9/7.
//  Copyright © 2018年 刘恒宇. All rights reserved.
//


import UIKit
import Eureka

class NewDealViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New Deal"
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reserve", style: .done, target: self, action: #selector())
        form +++ Section("Section1")
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Your salon's name"
            }
            <<< TextRow(){ row in
                row.title = "Address"
                row.placeholder = "Your salon's address"
            }
            <<< TextRow(){
                $0.title = "Price Row"
                $0.placeholder = "What's the price"
            }
            <<< DateRow(){
                $0.title = "Time"
                $0.value = Date()
        }
    }
}

