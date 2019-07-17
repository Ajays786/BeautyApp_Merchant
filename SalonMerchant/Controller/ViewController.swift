//
//  ViewController.swift
//  SalonMerchant
//
//  Created by 刘恒宇 on 2018/9/7.
//  Copyright © 2018年 刘恒宇. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            // add delay to solve the warning message "Unbalanced calls to begin"
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            // Ask for registor remote notification
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //            appDelegate.registerRemoteNotification(UIApplication.shared)
        }
    }
    
    @objc func handleLogout() {
        do {
            if let uid = Auth.auth().currentUser?.uid {
                Database.database().reference().child("users").child(uid).child("token").removeValue()
                print("Deleted user past token")
            } else {
                print("No user token have to be deleted")
            }
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        let navController = UINavigationController(rootViewController: loginController)
        navController.navigationBar.barStyle = .blackTranslucent
        present(navController, animated: true)
    }
    
    func newAD() {
        
        let newReservationVC = UINavigationController(rootViewController: NewDealViewController())
        newReservationVC.title = "New Deal"
        if #available(iOS 11.0, *) {
            newReservationVC.navigationBar.prefersLargeTitles = true
        }
        self.present(newReservationVC, animated: true, completion: nil)
        

    }
}

