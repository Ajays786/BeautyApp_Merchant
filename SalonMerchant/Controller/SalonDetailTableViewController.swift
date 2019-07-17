//
//  SalonDetailTableViewController.swift
//  Salon
//
//  Created by 刘恒宇 on 2018/9/7.
//  Copyright © 2018年 Hengyu Liu. All rights reserved.
//

import UIKit

class SalonDetailTableViewController: UITableViewController {
    
    var info: DealModel!
    @IBOutlet weak var nameCell: UITableViewCell!
    @IBOutlet weak var priceCell: UITableViewCell!
    @IBOutlet weak var timeCell: UITableViewCell!
    @IBOutlet weak var addressCell: UITableViewCell!
    
    @IBAction func newAppointmentButton(_ sender: UIBarButtonItem) {
        self.newAppointment()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameCell.textLabel?.text = info.name
        priceCell.textLabel?.text = "info.price"
        timeCell.textLabel?.text = "info.time)"
        addressCell.textLabel?.text = "info.address"
    }
}
