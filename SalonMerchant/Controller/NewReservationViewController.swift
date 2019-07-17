//
//  NewReservationViewController.swift
//  Salon
//
//  Created by mac on 2018/8/21.
//  Copyright © 2018年 Hengyu Liu. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class NewReservationViewController: FormViewController
{
    lazy var functions = Functions.functions()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = "New Offer"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reserve", style: .done, target: self, action: #selector(handleCreate))
        form
            +++ Section("Basic Info")
            <<< TextRow() { row in
                row.title = "Name"
                row.tag = "name"
                row.placeholder = "Enter deal's name here"
            }
            <<< TextRow() { row in
                row.title = "Address"
                row.tag = "address"
                row.placeholder = "Enter your address here"
            }
            <<< DecimalRow() {
                $0.title = "Price"
                $0.tag = "price"
                $0.placeholder = "Enter price for your offer here"
            }
            <<< PhoneRow(){
                $0.title = "Contact info"
                $0.tag = "contact"
                $0.placeholder = "Enter your phone numbers here"
            }
            <<< DateRow(){
                $0.title = "Date"
                $0.tag = "date"
                $0.value = Date()
            }
    }
    
    @objc func handleCreate() {
        guard let name = (self.form.rowBy(tag: "name") as! TextRow).value,
        let address = (self.form.rowBy(tag: "address") as! TextRow).value,
        let price = (self.form.rowBy(tag: "price") as! DecimalRow).value,
        let date = (self.form.rowBy(tag: "date") as! DateRow).value else {
            let alert = UIAlertController(title: "Please enter all info", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let uiBusy = UIActivityIndicatorView(style: .gray)
        uiBusy.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: uiBusy)
        
        let par: [String: AnyObject] = [
            "name": name as AnyObject,
            "address": address as AnyObject,
            "price": price as AnyObject,
//            "date": date as AnyObject,
            ]
        functions.httpsCallable("addOffer").call(par) { _, _ in
            // Ignore errors for now
            self.cancel()
            return
        }
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}

