	//
//  BidTableViewController.swift
//  SalonMerchant
//
//  Created by 刘恒宇 on 9/28/18.
//  Copyright © 2018 刘恒宇. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class BidDetailTableViewController: UITableViewController {
    
    lazy var functions = Functions.functions()
    
    var db: Firestore!
    var id: String!
    var bids: [BidDetailModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleCreate))
        
        loadTable()
    }
    
    func loadTable() {
        db = Firestore.firestore()
        
        let dealsRef = db.collection("reservation").document(id).collection("offers")
        dealsRef.addSnapshotListener { (snapshot, error) in
            guard let doc = snapshot else {
                print(error!)
                return
            }
            for change in doc.documentChanges {
                guard change.type == .added else {
                    continue
                }
                print(change.document.data())
                let temDeal = BidDetailModel(data: change.document.data())
                self.bids.append(temDeal)
            }
        }
    }
    
    @objc func handleCreate() {
        let loginSheet = UIAlertController(title: "Offer a bid", message: "Offer a new bid means...", preferredStyle: .alert)
        
        loginSheet.addTextField { (textField) in
            textField.placeholder = "Your price"
            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
            textField.spellCheckingType = .no
            textField.keyboardType = .numberPad
            textField.keyboardAppearance = .dark
            textField.returnKeyType = .done
        }

        loginSheet.addAction(UIAlertAction(title: "Bid", style: .default, handler: { (_) in
            let price = (loginSheet.textFields?[0].text)!
            let par: [String: AnyObject] = [
                "price": price as AnyObject,
                "pathID": self.id as AnyObject,
            ]
            print(par)
            self.functions.httpsCallable("makeBid").call(par) { _, _ in
                // Ignore errors for now
                return
            }
        }))
        
        loginSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(loginSheet, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bids.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bidDetailCell", for: indexPath)
        let dealObject = bids[indexPath.row]

        cell.detailTextLabel?.text = dealObject.price
        cell.textLabel?.text = dealObject.uid
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}
