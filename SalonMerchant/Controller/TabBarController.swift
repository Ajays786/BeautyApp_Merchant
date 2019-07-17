//
//  tabBarController.swift
//  Salon
//
//  Created by mac on 2018/8/18.
//  Copyright © 2018年 Hengyu Liu. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class TabBarController: ESTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadRootVC()
//        self.tabBar.shadowImage = UIImage(named: "transparent")
//        self.tabBar.backgroundImage = UIImage(named: "background_dark")
//        self.tabBar.barTintColor = UIColor(r:108,g:25,b:170)
//        self.tabBar.backgroundColor =  UIColor(r:108,g:25,b:170)
        self.tabBar.barTintColor = UIColor(r: 216, g: 219, b: 219)
        self.tabBar.backgroundColor =  UIColor(r: 216, g: 219, b: 219)
    }
//    "navetohappyhour") as! UINavigationController
//    let mainContent1VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navetomanageappointment") as! UINavigationController
//    let mainContent3VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navetomessage") as! UINavigationController
//    let mainContent4VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navtoprofile"
    
    func loadRootVC() {
        let mainContentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navtoprofile") as! UINavigationController
        let mainContent1VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navetomanageappointment") as! UINavigationController
        let mainContent3VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navetohappyhour") as! UINavigationController
        let mainContent4VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navetomessage") as! UINavigationController
        mainContentVC.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        mainContent1VC.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Appointments", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        mainContent3VC.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Offers", image: UIImage(named: "offers"), selectedImage: UIImage(named: "offers_1"))
        mainContent4VC.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Message", image: UIImage(named: "message"), selectedImage: UIImage(named: "message_1"))
        self.viewControllers = [mainContentVC, mainContent1VC, mainContent3VC, mainContent4VC]
    }
    
}
