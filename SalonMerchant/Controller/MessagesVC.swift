//
//  MessagesVC.swift
//  SalonMerchant
//
//  Created by Sagar Midha on 5/17/19.
//  Copyright © 2019 刘恒宇. All rights reserved.
//

import UIKit

class MessagesVC: BaseViewController, UITableViewDelegate, UITableViewDataSource
{
    //Mark: Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableVw: UITableView!
    var nameArray = ["Name"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        searchBar.backgroundImage = UIImage()
         
    }
    //Mark: Tableview Delegates & Data Sources
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomMesageCell
       cell?.selectionStyle = .none
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 124
    }
}
