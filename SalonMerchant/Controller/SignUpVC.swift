//
//  SignUpVC.swift
//  SalonMerchant
//
//  Created by Sagar Midha on 5/22/19.
//  Copyright © 2019 刘恒宇. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import UIKit
import FirebaseFirestore

class SignUpVC: BaseViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    //Mark: Outlets
    lazy var functions = Functions.functions()
    @IBOutlet weak var fNameTxtFld: UITextField!
    @IBOutlet weak var lastNameTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var pwdTxtFld: UITextField!
    @IBOutlet weak var cPwdTxtFld: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        setAttributes()
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width/2
        self.profileImageView.clipsToBounds = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resignKeyboard)))
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        imagePicker.delegate = self
    }
    //Mark: Add Image Button
    @IBAction func addBtn(_ sender: Any)
    {
        handleSelectProfileImageView()
    }
    
    
    @IBAction func submitBtn(_ sender: Any)
    {
        handleRegister()
    }
    
    
    //Mark: Set Attributes & Corner Radius & Set bottomline in textfeild
    func setAttributes()
    {
//        submitBtn.layer.cornerRadius = 10
        fNameTxtFld.useUnderline()
        lastNameTxtFld.useUnderline()
        emailTxtFld.useUnderline()
        pwdTxtFld.useUnderline()
        cPwdTxtFld.useUnderline()
        
        let bottomLine = CALayer()
        bottomLine.backgroundColor = UIColor.white.cgColor
        fNameTxtFld.borderStyle = UITextField.BorderStyle.none
        fNameTxtFld.layer.addSublayer(bottomLine)
        lastNameTxtFld.borderStyle = UITextField.BorderStyle.none
        lastNameTxtFld.layer.addSublayer(bottomLine)
        emailTxtFld.borderStyle = UITextField.BorderStyle.none
        emailTxtFld.layer.addSublayer(bottomLine)
        pwdTxtFld.borderStyle = UITextField.BorderStyle.none
        pwdTxtFld.layer.addSublayer(bottomLine)
        cPwdTxtFld.borderStyle = UITextField.BorderStyle.none
        cPwdTxtFld.layer.addSublayer(bottomLine)
        //
        fNameTxtFld.attributedPlaceholder = NSAttributedString(string: "Enter the First Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        lastNameTxtFld.attributedPlaceholder = NSAttributedString(string: "Enter the Last Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailTxtFld.attributedPlaceholder = NSAttributedString(string: "Enter the Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        pwdTxtFld.attributedPlaceholder = NSAttributedString(string: "Enter the Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        cPwdTxtFld.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fNameTxtFld {
            lastNameTxtFld.becomeFirstResponder()
        } else if textField == lastNameTxtFld {
            emailTxtFld.becomeFirstResponder()
        } else if textField == emailTxtFld {
            pwdTxtFld.becomeFirstResponder()
        } else if textField == pwdTxtFld {
              cPwdTxtFld.becomeFirstResponder()
        }
        else if textField == cPwdTxtFld {
            handleRegister()
        }
        return false
    }
    
    @objc func resignKeyboard() {
        fNameTxtFld.resignFirstResponder()
        lastNameTxtFld.resignFirstResponder()
        emailTxtFld.resignFirstResponder()
        pwdTxtFld.resignFirstResponder()
        cPwdTxtFld.resignFirstResponder()
    }
    
    @objc func handleRegister() {
        resignKeyboard()
        
        guard let email = emailTxtFld.text, let password = pwdTxtFld.text, let name = fNameTxtFld.text, let lastname = lastNameTxtFld.text,   let repeatPassword = cPwdTxtFld.text
            else {
                fatalError("textfield is nil")
        }
        if fNameTxtFld.text == "" {
            fNameTxtFld.shake(2, withDelta: 4, speed: 0.07)
            fNameTxtFld.attributedPlaceholder = NSAttributedString(string: "First Name cannot be empty", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        if lastNameTxtFld.text == "" {
            lastNameTxtFld.shake(2, withDelta: 4, speed: 0.07)
            lastNameTxtFld.attributedPlaceholder = NSAttributedString(string: "Last Name cannot be empty", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        if emailTxtFld.text == "" {
            emailTxtFld.shake(2, withDelta: 4, speed: 0.07)
            emailTxtFld.attributedPlaceholder = NSAttributedString(string: "Email cannot be empty", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        
        if pwdTxtFld.text == "" {
            pwdTxtFld.shake(2, withDelta: 4, speed: 0.07)
            pwdTxtFld.attributedPlaceholder = NSAttributedString(string: "Password cannot be empty", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        if cPwdTxtFld.text == "" {
            cPwdTxtFld.shake(2, withDelta: 4, speed: 0.07)
            cPwdTxtFld.attributedPlaceholder = NSAttributedString(string: "Confirm Password cannot be empty", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        if (emailTxtFld.text == "") || (pwdTxtFld.text == "") {
            
            return
        }
        
        if repeatPassword != password {
            self.pwdTxtFld.shake(2, withDelta: 4, speed: 0.07)
            self.cPwdTxtFld.shake(2, withDelta: 4, speed: 0.07)
            self.cPwdTxtFld.text = ""
            self.pwdTxtFld.text = ""
            self.pwdTxtFld.attributedPlaceholder = NSAttributedString(string: "Please double check your password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error != nil {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .invalidEmail:
                        self.emailTxtFld.shake(2, withDelta: 4, speed: 0.07)
                        self.emailTxtFld.text = ""
                        self.pwdTxtFld.text = ""
                        self.cPwdTxtFld.text = ""
                        self.emailTxtFld.attributedPlaceholder = NSAttributedString(string: "🌚 Email address is invalid", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    case .emailAlreadyInUse:
                        self.emailTxtFld.shake(2, withDelta: 4, speed: 0.07)
                        self.emailTxtFld.text = ""
                        self.pwdTxtFld.text = ""
                        self.cPwdTxtFld.text = ""
                        self.emailTxtFld.attributedPlaceholder = NSAttributedString(string: "🌚 Account has existed", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    case .weakPassword:
                        self.pwdTxtFld.shake(2, withDelta: 4, speed: 0.07)
                        self.pwdTxtFld.text = ""
                        self.cPwdTxtFld.text = ""
                        self.cPwdTxtFld.attributedPlaceholder = NSAttributedString(string: "🌚 Your password is too weak", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    default:
                        self.emailTxtFld.shake(2, withDelta: 4, speed: 0.07)
                        self.pwdTxtFld.shake(2, withDelta: 4, speed: 0.07)
                        self.emailTxtFld.text = ""
                        self.pwdTxtFld.text = ""
                        self.cPwdTxtFld.text = ""
                    }
                }
                return
            }
            
            let values: [String: AnyObject] = ["name": name + " " + lastname as AnyObject,"Type":"Merchant" as AnyObject]
            self.functions.httpsCallable("createUser").call(values) { (result, err) in
                guard err == nil else {
                    print(err!)
                    return
                }
                print("User created")
            }
            
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
            if let profileImage = self.profileImageView.image, let uploadData = profileImage.jpegData(compressionQuality: 0.1) {
                // change to JPEG for better compression, current resolution: 0.1
                storageRef.putData(uploadData, metadata: nil, completion: { metadata, error in
                    if error != nil {
                        print(error!)
                        return
                    }
                    let db = Firestore.firestore()
                    let dealsRef = db.collection("user").document(Auth.auth().currentUser?.uid ?? "")
                    dealsRef.updateData(["icon": imageName as Any])
                })
            }
            

            self.dismiss(animated: true, completion: nil)
            

        }
    }
    
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { err, _ in
            if err != nil {
                print(err!)
                return
            }
            print("reg success")
            //            let user = User(dictionary: values)
            //            user.uid = uid
            //            self.messageController?.fetchUserAndSetupNavBarTitle()
            //            let classPickerController = ClassPickerController()
            //            classPickerController.user = user
            //            self.navigationController?.pushViewController(classPickerController, animated: true)
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupKeyboardObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleKeyboardWillShow(_ notification: Notification) {
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        UIView.animate(withDuration: keyboardDuration!, animations: {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                
                self.view.frame.origin.y = ((self.view.frame.height - (self.submitBtn.frame.maxY + 12 + keyboardHeight)) > -100) && ((self.view.frame.height - (self.submitBtn.frame.maxY + 12 + keyboardHeight)) < 0) ? (self.view.frame.height - (self.submitBtn.frame.maxY + 12 + keyboardHeight)) : -100
            } else {
                self.view.frame.origin.y = -100
            }
        })
    }
    
    @objc func handleKeyboardWillHide(_ notification: Notification) {
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.frame.origin.y = 0
        })
    }
    
    @objc func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
//     func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
//        var selectedImageFromPicker: UIImage?
//
//        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
//            selectedImageFromPicker = editedImage
//        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
//            selectedImageFromPicker = originalImage
//        }
//
//        if let selectedImage = selectedImageFromPicker {
//            profileImageView.image = selectedImage
//        }
//
//        dismiss(animated: true, completion: nil)
//    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
}




