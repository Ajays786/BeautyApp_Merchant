//
//  EditProfileTableViewController.swift
//  SalonMerchant
//
//  Created by Sagar Midha on 5/15/19.
//  Copyright © 2019 刘恒宇. All rights reserved.
//

import UIKit

class EditProfileTableViewController: BaseViewController
{
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var instagramBtn: LoadingButton!
    @IBOutlet weak var happyHourBtn: LoadingButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setContent()
        self.navigationItem.title = "Edit Profile"
        self.navigationController?.navigationBar.topItem?.title = " "
    }
 //Mark: Set Corner Radius
    
   func setContent()
   {
  
    self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2

    

    
    }
}
