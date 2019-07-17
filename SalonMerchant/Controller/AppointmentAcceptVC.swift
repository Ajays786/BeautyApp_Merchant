//
//  AppointmentAcceptVC.swift
//  SalonMerchant
//
//  Created by Sagar Midha on 5/17/19.
//  Copyright © 2019 刘恒宇. All rights reserved.
//

import UIKit

class AppointmentAcceptVC: UIViewController
{
    @IBOutlet weak var appoinmentImgVw: UIImageView!
   
    @IBOutlet weak var appointmentAcceptedLbl: UILabel!
    @IBOutlet weak var dataVw: UIView!
    @IBOutlet weak var dataVwClientNameLbl: UILabel!
    @IBOutlet weak var dataVwServiceRequested: UILabel!
    @IBOutlet weak var dataVwTimeLbl: UILabel!
    @IBOutlet weak var dataVwpriceLbl: UILabel!
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.topItem?.title = " "
        setOrder()
    }
    
    func setOrder()
    {
        dataVw.layer.cornerRadius = 5
        declineBtn.layer.cornerRadius = 25
        confirmBtn.layer.cornerRadius = 25
    }
    func setBarBtn()
    {
        let button1 = UIBarButtonItem(image: UIImage(named: "close2x"), style: .plain, target: self, action: #selector(getter: UIDynamicBehavior.action)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = button1
    }
    @IBAction func declineBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func confirmBtn(_ sender: Any)
    {
        
    }
    
    
}
