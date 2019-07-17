//
//  BidTableViewController.swift
//  Salon
//
//  Created by 刘恒宇 on 9/28/18.
//  Copyright © 2018 Hengyu Liu. All rights reserved.
//
import UIKit
import Firebase
import FirebaseFirestore

class BidTableViewController: UITableViewController
{
    lazy var functions = Functions.functions()
    var db: Firestore!
    var bids: [(String, BidModel)] = []
    {
        didSet
        {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadTable()
    }
    
    func loadTable() {
        db = Firestore.firestore()
        
        let dealsRef = db.collection("reservation")
        dealsRef.addSnapshotListener { (snapshot, error) in
            self.reloadDB()
        }
    }

    func reloadDB() {
        self.bids.removeAll()
        db = Firestore.firestore()
        let dealsRef = db.collection("reservation")
        dealsRef.getDocuments { (snapshot, error) in
            guard let doc = snapshot else {
                print(error!)
                return
            }
            for d in doc.documents {
                let id = d.documentID
                let temDeal = BidModel(data: d.data())
                self.bids.append((id, temDeal))
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("lhy \(bids.count)")
        return bids.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bidCell", for: indexPath)
        let dealObject = bids[indexPath.row]
        cell.tag = indexPath.row
        
        
        cell.textLabel?.text = dealObject.1.style
        if dealObject.1.status {
            cell.detailTextLabel?.text = "Pending"
        } else {
            cell.detailTextLabel?.text = "Biding"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)?.isSelected = false
        let dealObject = bids[indexPath.row]
        if dealObject.1.status {
            let alert = UIAlertController(title: "Do you accept?", message: dealObject.1.chosen, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                self.handleMakeBid(chosen: dealObject.0, uid: dealObject.1.uid)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
                
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: "bidDetail", sender: tableView.cellForRow(at: indexPath))
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bidDetail" {
            let cell = sender as! UITableViewCell
            let detailController = segue.destination as! BidDetailTableViewController
            detailController.id = bids[cell.tag].0
        }
    }
}

extension BidTableViewController {
    func handleMakeBid(chosen: String, uid: String) {
        let par: [String: AnyObject] = [
            "buyer": uid as AnyObject,
            "chosen": chosen as AnyObject,
            ]
        functions.httpsCallable("confirmBid").call(par) { _, _ in
            // Ignore errors for now
            print("lhy finish confirmBid")
            return
        }
    }
}
