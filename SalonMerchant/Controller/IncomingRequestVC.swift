//
//  IncomingRequestVC.swift
//  SalonMerchant
//
//  Created by Sagar Midha on 5/17/19.
//  Copyright © 2019 刘恒宇. All rights reserved.
//
import UIKit

class IncomingRequestVC: UIViewController
{
    @IBOutlet weak var contentVw: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var serviceLbl: UILabel!
    @IBOutlet weak var timeDateLbl: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var typeInBidTxtFld: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = "Incoming Request"
        self.navigationController?.navigationBar.topItem?.title = " "
    }
    @IBAction func sendBtn(_ sender: Any)
    {
        
    }
}
