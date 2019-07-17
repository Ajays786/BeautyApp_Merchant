//
//  DealModel.swift
//  Salon
//
//  Created by 刘恒宇 on 2018/9/7.
//  Copyright © 2018年 Hengyu Liu. All rights reserved.
//

import Foundation
import CoreLocation
import FirebaseFirestore

class DealModel {
    var name: String
    //    var coordinate: CLLocationCoordinate2D
//    var address: String
//    var price: Double
//    var time: Date
    
    init(data: [String: Any]) {
        guard let name = data["name"] as? String else {
            self.name = "null name"
            return
        }
        self.name = name
        //        self.coordinate = CLLocationCoordinate2D(latitude: coordinate.0, longitude: coordinate.1)
//        self.address = address
//        self.price = price
//        self.time = time.dateValue()
    }
}
