//
//  ProfileviewController.swift
//  SalonMerchant
//
//  Created by Sagar Midha on 6/20/19.
//  Copyright © 2019 刘恒宇. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import Crashlytics
class ProfileviewController: BaseViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate,SelectServiceDelegate
{
   
    var notification = false
    var Insta = false
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var showcaseLbl: UILabel!
    @IBOutlet weak var img1Btn: UIButton!
    @IBOutlet weak var img2Btn: UIButton!
    @IBOutlet weak var img3Btn: UIButton!
    @IBOutlet weak var streetAddressTextFeild: UITextField!
    @IBOutlet weak var cityTextFeild: UITextField!
    @IBOutlet weak var stateTextFeild: UITextField!
    @IBOutlet weak var zipcodeTextFeild: UITextField!
    @IBOutlet weak var servicesOfferedBtn: UIButton!
    @IBOutlet weak var instagramTxtFld: UITextField!
    @IBOutlet weak var notifyTxtFld: UITextField!
    @IBOutlet weak var instgramLinkSwitchBtn: UISwitch!
    @IBOutlet weak var notifySwitchBtn: UISwitch!
    @IBOutlet weak var cancelPolicyLbl: UILabel!
    @IBOutlet weak var policyTxtView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var ShowCase1: UIButton!
    @IBOutlet weak var ShowCase2: UIButton!
    @IBOutlet weak var ShowCase3: UIButton!
    var name = ""
    var Profile = UIImage()
    var Services = [String]()
     var db: Firestore!
     var Tag = 0
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        instagramTxtFld.isUserInteractionEnabled = false
        notifyTxtFld.isUserInteractionEnabled = false
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfile)))
        self.navigationItem.title = "Edit Profile"
        self.navigationController?.navigationBar.topItem?.title = " "
        bioTextView.textColor = UIColor.lightGray
        policyTxtView.textColor = UIColor.lightGray
          db = Firestore.firestore()
        self.profileNameLbl.text = name
        self.profileImage.image = Profile
        roundedCorner()
        loadTable()
    }

    func roundedCorner()
    {
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width/2
        bioTextView.layer.cornerRadius = 10
        servicesOfferedBtn.layer.cornerRadius = 25
        saveButton.layer.cornerRadius = 25
        policyTxtView.layer.cornerRadius = 10
        img1Btn.layer.cornerRadius = 10
        img2Btn.layer.cornerRadius = 10
        img3Btn.layer.cornerRadius = 10
    }
    @objc func handleProfile(){
        OpenImagePicker()
        Tag = 4
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
       
        if Tag == 1{
        ShowCase1.setImage(selectedImageFromPicker, for: .normal)
        }
        else if Tag == 2{
            ShowCase2.setImage(selectedImageFromPicker, for: .normal)
        }
        else if Tag == 3{
            ShowCase3.setImage(selectedImageFromPicker, for: .normal)
        }
        else if Tag == 4{
             self.profileImage.image = selectedImageFromPicker
                    if let selectedImage = selectedImageFromPicker {
                        let imageName = NSUUID().uuidString
                        let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
                        if let uploadData = selectedImage.jpegData(compressionQuality: 0.1) {
                            // change to JPEG for better compression, current resolution: 0.1
                            storageRef.putData(uploadData, metadata: nil, completion: { metadata, error in
                                if error != nil {
                                    print(error!)
                                    return
                                }
                                let dealsRef = self.db.collection("user").document(Auth.auth().currentUser?.uid ?? "")
                                dealsRef.updateData(["icon": imageName as Any])
                            })
                        }
                    }
        }
      
      

        
        dismiss(animated: true, completion: nil)
    }
//  private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        var selectedImageFromPicker: UIImage?
//
//        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
//            selectedImageFromPicker = editedImage
//        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
//            selectedImageFromPicker = originalImage
//        }
//        self.profileImage.image = selectedImageFromPicker
//        if let selectedImage = selectedImageFromPicker {
//            let imageName = NSUUID().uuidString
//            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
//            if let uploadData = selectedImage.jpegData(compressionQuality: 0.1) {
//                // change to JPEG for better compression, current resolution: 0.1
//                storageRef.putData(uploadData, metadata: nil, completion: { metadata, error in
//                    if error != nil {
//                        print(error!)
//                        return
//                    }
//                    let dealsRef = self.db.collection("user").document(Auth.auth().currentUser?.uid ?? "")
//                    dealsRef.updateData(["icon": imageName as Any])
//                })
//            }
//        }
//
//        dismiss(animated: true, completion: nil)
//    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func ShowCaseButton1(_ sender: UIButton) {
        Tag = sender.tag
         OpenImagePicker()
    }
    @IBAction func ShowCaseButton2(_ sender: UIButton) {
         Tag = sender.tag
         OpenImagePicker()
    }
    @IBAction func ShowCaseButton3(_ sender: UIButton) {
         Tag = sender.tag
        OpenImagePicker()
    }
    
    @IBAction func ServiceOffered(_ sender: Any) {
        
       let vc =  self.storyboard?.instantiateViewController(withIdentifier: "SelectServicesVC") as! SelectServicesVC
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func OpenImagePicker(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func loadTable() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        print(uid)
        db = Firestore.firestore()
         let dealsRef = db.collection("MSettings").document(Auth.auth().currentUser?.uid ?? "")
        dealsRef.addSnapshotListener { (snapshot, error) in
            guard let doc = snapshot else {
                print(error!)
                return
            }
            if doc.data() != nil{
                let Setting = Settings(data: doc.data()!)
                print(Setting)
                self.bioTextView.text =  Setting.Bio
                self.bioTextView.textColor = UIColor.black
                 self.policyTxtView.textColor = UIColor.black
                self.streetAddressTextFeild.text = Setting.StreetAddress
                self.cityTextFeild.text = Setting.City
                self.stateTextFeild.text = Setting.State
                self.zipcodeTextFeild.text = Setting.Zip
                self.notifySwitchBtn.setOn(Setting.Notification, animated: true)
                self.instgramLinkSwitchBtn.setOn(Setting.LinkInstagram, animated: true)
                self.policyTxtView.text = Setting.CancelationPolicy
                print(Setting.Bio)
                print(Setting.CancelationPolicy)
                print(Setting.City)
                  print(Setting.State)
                 print(Setting.StreetAddress)
                 print(Setting.Zip)
                print(Setting.LinkInstagram)
                print(Setting.Notification)
                 print(Setting.Services)
                
              
            }
            
            //            for change in doc.documentChanges {
            ////                change.document.data(with: <#T##ServerTimestampBehavior#>)
            //                print(change.document.data())
            //                let data = change.document.data()
            //                print(data)
            ////                let temDeal = DealModel(data: change.document.data())
            ////                print(temDeal)
            //            }
        }
    }
    @IBAction func SaveButton(_ sender: Any) {
        if bioTextView.text.trimmingCharacters(in: .whitespaces) == "Tell People what you're good at."{
            self.alert(message: "Please Tell People what you're good at.")
        }
        else  if streetAddressTextFeild.text?.trimmingCharacters(in: .whitespaces) == ""{
            self.alert(message: "Please enter street address")
        }
        else  if cityTextFeild.text?.trimmingCharacters(in: .whitespaces) == ""{
            self.alert(message: "Please enter city name")
        }
        else  if stateTextFeild.text?.trimmingCharacters(in: .whitespaces) == ""{
            self.alert(message: "Please enter state name")
        }
        else  if zipcodeTextFeild.text?.trimmingCharacters(in: .whitespaces) == ""{
            self.alert(message: "Please enter zip code ")
        }
        else  if policyTxtView.text?.trimmingCharacters(in: .whitespaces) == "Let Customers know what your cancellation policy is. This will show up before they book an appointment with you and must agree in order to process your booking."{
            self.alert(message: "Please enter your cancelation policy")
        }
        else{
        let par: [String: AnyObject] = [
            "Bio": self.bioTextView.text as AnyObject ,"ShowCase": "ShowCase" as AnyObject , "StreetAddress": self.streetAddressTextFeild.text  as AnyObject , "City": self.cityTextFeild.text  as AnyObject ,"State": self.stateTextFeild.text  as AnyObject ,"Services": self.Services as AnyObject , "Zip": self.zipcodeTextFeild.text as AnyObject,"LinkInstagram": self.Insta  as AnyObject ,"Notification": self.notification  as AnyObject ,"CancelationPolicy": self.policyTxtView.text  as AnyObject ,
        ]
        db = Firestore.firestore()
        let dealsRef = db.collection("MSettings").document(Auth.auth().currentUser?.uid ?? "")
        dealsRef.setData(par)
        self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    func ServicesList(Services: Array<String>) {
        self.Services = Services
    }
    
    @IBAction func LinkInstaSwitch(_ sender: UISwitch) {
        if sender.state.rawValue == 0{
            self.Insta = false
        }
        else  if sender.state.rawValue == 1{
            self.Insta = true
        }
    }
    @IBAction func NotificationSwitch(_ sender: UISwitch) {
        if sender.state.rawValue == 0{
            self.notification = false
        }
        else  if sender.state.rawValue == 1{
            self.notification = true
        }
    }
    
    @IBAction func NameEditButton(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Update Name", message: "Enter new name", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Enter new name"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            // Force unwrapping because we know it exists.
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            if ((textField?.text?.trimmingCharacters(in: .whitespacesAndNewlines)) != ""){
                let dealsRef = self.db.collection("user").document(Auth.auth().currentUser?.uid ?? "")
                dealsRef.updateData(["name": textField?.text as Any])

                //                self.updateUserName(withUid: userID, toNewName: (textField?.text)!)
                
            }
            else{
                self.alert(message: "Please enter valid name ")
            }
            print("Text field: \(textField?.text)")
            //Send Reset Password Link
            //
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == bioTextView {
            if textView.text.isEmpty{
                textView.text = "Tell People what you're good at."
                textView.textColor = UIColor.lightGray
            }
            
        }
        else if textView == policyTxtView{
            if textView.text.isEmpty{
                textView.text = "Let Customers know what your cancellation policy is. This will show up before they book an appointment with you and must agree in order to process your booking."
                textView.textColor = UIColor.lightGray
            }
        }
    }
}

