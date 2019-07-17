//
//  BidModel.swift
//  Salon
//
//  Created by 刘恒宇 on 9/28/18.
//  Copyright © 2018 Hengyu Liu. All rights reserved.
//

import Foundation
import CoreLocation
import FirebaseFirestore

class BidModel {
    var style: String
    var uid: String
    var status: Bool
    var chosen: String?
    
    init(data: [String: Any]) {
        guard let style = data["style"] as? String,
            let uid = data["userID"] as? String else {
                self.style = "NULL"
                self.uid = "NULL"
                self.status = false
                return
        }
        self.style = style
        self.uid = uid
        self.status = data["status"] as? Bool ?? false
        if status {
            chosen = data["chosen"] as? String
        }
    }
}

class AppointmentModel {
    var style = ""
    var uid = ""
    var status =  Bool()
    var chosen = ""
     var Services =  [String]()
    var Time = ""
    var Date = ""
    var MilesAway = ""
    var Zip = ""
    var Price = ""
     var Name = ""
    init(data: [String: Any]) {
        if let uid = data["userID"] as? String{
            self.uid = uid
        }
        else{
            self.uid = ""
        }
        if let status = data["status"] as? Bool{
            self.status = status
        }
        else{
            self.status = false
        }
        if let Services = data["Services"] as? [String]{
            self.Services = Services
        }
        else{
            self.Services = []
        }
        if let Zip = data["Zip"] as? String{
            self.Zip = Zip
        }
        else{
            self.Zip = ""
        }
        if let MilesAway = data["MilesAway"] as? String{
            self.MilesAway = MilesAway
        }
        else{
            self.MilesAway = ""
        }
        if let Price = data["Price"] as? String{
            self.Price = Price
        }
        else{
            self.Price = ""
        }
        if let Time = data["Time"] as? String{
            self.Time = Time
        }
        else{
            self.Time = ""
        }
        if let Name = data["Name"] as? String{
            self.Name = Name
        }
        else{
            self.Name = ""
        }
        if let Date = data["Date"] as? String{
            self.Date = Date
        }
        else{
            self.Date = ""
        }
    }
}
