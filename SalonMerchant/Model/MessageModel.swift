//
//  MessageModel.swift
//  SalonMerchant
//
//  Created by 刘恒宇 on 10/5/18.
//  Copyright © 2018 刘恒宇. All rights reserved.
//

import Foundation
import FirebaseFirestore

class MessageModel {
    var merchantName: String?
    var customerName: String?
    var reservationID: String?
    init(data: [String: Any]) {
        guard let reservationID = data["reservationID"] as? String else {
            return
        }
        guard let mName = data["merchantName"] as? String, let cName = data["customerName"] as? String else {
            return
        }
        self.merchantName = mName
        self.customerName = cName
        self.reservationID = reservationID
    }
}
