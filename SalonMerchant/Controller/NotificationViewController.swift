//
//  NotificationViewController.swift
//  Salon
//
//  Created by Rahul Tiwari on 6/13/19.
//  Copyright © 2019 Hengyu Liu. All rights reserved.
//

import UIKit

class NotificationViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
  
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
//    func jayesh(a:Int,b:Int)->String{
//        return String
//    }

//    func jayesh1(a:Int,b:Int)->Int{
//        return Int
//    }

}
