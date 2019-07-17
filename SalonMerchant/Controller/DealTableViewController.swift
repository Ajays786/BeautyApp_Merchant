//
//  DealTableViewController.swift
//  Salon
//
//  Created by 刘恒宇 on 2018/8/28.
//  Copyright © 2018年 Hengyu Liu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class DealTableViewController: UITableViewController {
    
    var db: Firestore!
    var deals: [DealModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTable()
        checkIfUserIsLoggedIn()
    }
    
    func loadTable() {
        db = Firestore.firestore()
        
        let dealsRef = db.collection("deals")
        dealsRef.addSnapshotListener { (snapshot, error) in
            guard let doc = snapshot else {
                print(error!)
                return
            }
            for change in doc.documentChanges {
                print(change.document.data())
                let temDeal = DealModel(data: change.document.data())
                self.deals.append(temDeal)
            }
        }
    }
    
    @IBAction func rightNavigationItemAction(_ sender: Any) {
        self.newAppointment()
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dealCell", for: indexPath) as! DealTableViewCell
        let dealObject = deals[indexPath.row]
        
        cell.name.text = dealObject.name
        cell.address.text = "dealObject.address"
        cell.price.text = "dealObject.price"
        cell.time.text = "dealObject.time"
        
        cell.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dealCell = sender as? DealTableViewCell {
            let desTVC = segue.destination as! SalonDetailTableViewController
            desTVC.info = deals[dealCell.tag]
        }
    }
    
}
