//
//  MyTableViewController.swift
//  Salon
//
//  Created by mac on 2018/8/19.
//  Copyright © 2018年 Hengyu Liu. All rights reserved.
//

import UIKit
import Firebase

class MyTableViewController: UITableViewController {
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var logoutCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userAvatarImageView.layer.cornerRadius = 5
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
        
//        let loginController = LoginViewController()
//        let navController = UINavigationController(rootViewController: loginController)
////        navController.navigationBar.barStyle = .blackTranslucent
//        present(navController, animated: true)
        let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        let navController = UINavigationController(rootViewController: loginController)
        navController.navigationBar.barStyle = .blackTranslucent
        present(navController, animated: true)
    }
    
    // MARK: - Table view data source
    
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "userProfileCell", for: indexPath)
    //
    //        // Configure the cell...
    //
    //        return cell
    //    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.tableView.cellForRow(at: indexPath) == logoutCell {
            self.handleLogout()
        }
    }
    
    
}
