//
//  MessageDetailModel.swift
//  Salon
//
//  Created by 刘恒宇 on 10/12/18.
//  Copyright © 2018 Hengyu Liu. All rights reserved.
//

import Foundation

class MessageDetailModel {
    var message: String?
    var senderID: String?
    init(data: [String: Any]) {
        guard let message = data["message"] as? String else {
            return
        }
        self.message = message
        guard let senderID = data["senderID"] as? String else {
            return
        }
        self.senderID = senderID
    }
}


class Settings{
    var StreetAddress = ""
    var CancelationPolicy = ""
    var City = ""
    var State = ""
    var Bio = ""
    var Zip = ""
    var ShowCase = ""
    var Notification = Bool()
    var LinkInstagram = Bool()
    var Services = [String]()
    
    //    override init() {}
    //    init(Distance: String, Zip: String, Notification: Bool, Services: [String]) {
    //       self.Distance = Distance
    //        self.Zip = Zip
    //        self.Notification = Notification
    //        self.Services = Services
    //    }
    init(data: [String: Any]) {
        if let StreetAddress = data["StreetAddress"] as? String{
            self.StreetAddress = StreetAddress
        }
        else {
            self.StreetAddress = ""
        }
        if let City = data["City"] as? String{
            self.City = City
        }
        else {
            self.City = ""
        }
        if let State = data["State"] as? String{
            self.State = State
        }
        else {
            self.State = ""
        }
        if let Bio = data["Bio"] as? String{
            self.Bio = Bio
        }
        else {
            self.Bio = ""
        }
        if let CancelationPolicy = data["CancelationPolicy"] as? String{
            self.CancelationPolicy = CancelationPolicy
        }
        else {
            self.CancelationPolicy = ""
        }
        if let Zip = data["Zip"] as? String{
            self.Zip = Zip
        }
        else{
            self.Zip = "Zip"
        }
        if let Notification = data["Notification"] as? Bool{
            self.Notification = Notification
        }
        else{
            self.Notification = false
        }
        if let LinkInstagram = data["LinkInstagram"] as? Bool{
            self.LinkInstagram = LinkInstagram
        }
        else{
            self.Notification = false
        }
        if let Services = data["Services"] as? [String]{
            self.Services = Services
        }
        else{
            self.Services = []
        }
    }
}


//["LinkInstagram": 1, "Services": <__NSArrayM 0x60000235fdb0>(
//
//    )
//    , "StreetAddress": phase 8, "Zip": 160051, "Notification": 1, "ShowCase": ShowCase, "CancelationPolicy": Let Customers know what your cancellation policy is. This will show up before they book an appointment with you and must agree in order to process your booking., "State": Punjab, "Bio": Tell People what you're good at., "City": Mohali]
