
//
//  extensions.swift
//  SalonMerchant
//
//  Created by Sagar Midha on 5/22/19.
//  Copyright © 2019 刘恒宇. All rights reserved.
//

import UIKit
import CoreLocation
//Mark: Set underLine Of Textfeilds in SignUp Screen

extension UITextField
{
    
    func useUnderline()
    {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
//Mark: Set Image as profile
extension UIImageView
{
    func setImage(from urlAddress: String?)
    {
        guard let urlAddress = urlAddress, let url = URL(string: urlAddress) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async
                {
                    self.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}

extension UIViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


//Mark: Alert Show & Validate Email

extension UIViewController
{
    
    
    public func ValidateData(strMessage: String) -> Bool
    {
        let alert = UIAlertController(title: "Signup", message: strMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return true
    }
    public func isValidEmail(emailID:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
}

extension Array where Element: Equatable {
    mutating func appendUniqueObject(object: Iterator.Element) {
        if contains(object) == false {
            append(object)
        }
    }
}
class Alerts {
    static func showActionsheet(viewController: UIViewController, title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for (index, (title, style)) in actions.enumerated() {
            let alertAction = UIAlertAction(title: title, style: style) { (_) in
                completion(index)
            }
            alertViewController.addAction(alertAction)
        }
        viewController.present(alertViewController, animated: true, completion: nil)
    }
}
extension CLLocationDistance {
    func inMiles() -> CLLocationDistance {
        return self*0.00062137
    }
    
    func inKilometers() -> CLLocationDistance {
        return self/1000
    }
}
