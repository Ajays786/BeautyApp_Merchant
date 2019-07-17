//
//  LoginVC.swift
//  SalonMerchant
//
//  Created by Sagar Midha on 5/22/19.
//  Copyright © 2019 刘恒宇. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class LoginVC: BaseViewController
{
    //Mark: Outlets
    
    @IBOutlet weak var titleImgVW: UIImageView!
    @IBOutlet weak var contentVw: UIView!
    @IBOutlet weak var contentTitleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var userNameTxtFld: UITextField!
    @IBOutlet weak var pwdTxtFld: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var fbLoginBtn: UIButton!
    @IBOutlet weak var gmailLoginBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setCorner()
    }
    
    //Mark: Sjubmit Button
    @IBAction func submitBtn(_ sender: Any)
    {
        let logVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileTableViewController") as? ProfileTableViewController
        self.navigationController?.pushViewController(logVC!, animated: true)
    }
     //Mark: Facebook Login
    
    @IBAction func fbLoginBtn(_ sender: Any)
    {
        
    }
    //Mark: Gmail Signin Button
    @IBAction func gmailLoginBtn(_ sender: Any)
    {
        
    }
    
    //Mark: Create Account Button
    @IBAction func createAccountBtn(_ sender: Any)
    {
        let signUpVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    //Mark: Set Corner Radius
    func setCorner()
    {
        submitBtn.layer.cornerRadius = self.view.frame.width / 15
        contentVw.layer.cornerRadius = 5
    }
}
