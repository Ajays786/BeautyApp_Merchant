//
//  BaseViewController.swift
//  SalonMerchant
//
//  Created by Rahul Tiwari on 5/27/19.
//  Copyright © 2019 刘恒宇. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.image = #imageLiteral(resourceName: "BG")
        view.insertSubview(backgroundImageView, at: 0)
        // Do any additional setup after loading the view.
//        let templateImage = imgvBuilding.image?.withRenderingMode(.alwaysTemplate)
//        imgvBuilding.image = templateImage
//        imgvBuilding.tintColor = UIColor.red
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
