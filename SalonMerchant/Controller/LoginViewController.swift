//
//  LoginViewController.swift
//  Salon
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 Hengyu Liu. All rights reserved.
//

import Firebase
import GoogleSignIn
import UIKit
import UITextField_Shake
import FirebaseFirestore
class LoginViewController: BaseViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var FacebookButton: UIButton!
    @IBOutlet weak var GoogleButton: UIButton!
        var db: Firestore!
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == EmailTextField {
            PasswordTextField.becomeFirstResponder()
        } else if textField == PasswordTextField {
            handleLogin()
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == EmailTextField {
            EmailTextField.placeholder = "Email"
        } else if textField == PasswordTextField {
            PasswordTextField.placeholder = "Password"
        }
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
         LoginButton.layer.cornerRadius = self.view.frame.width / 15
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.view.backgroundColor = UIColor.clear
//        navigationController?.navigationBar.tintColor = UIColor.white
//
//        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
//        view.addSubview(inputsContainerView)
//        view.addSubview(loginButton)
//        view.addSubview(logoImageView)
//        view.addSubview(registerButton)
//
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resignKeyboard)))
//
//        emailTextField.delegate = self
//        passwordTextField.delegate = self
//
//        setupInputsContainerView()
//        setupLoginButton()
//        setupLogo()
//        setupRegisterButton()
    }
    
    @IBAction func CreateAccountAction(_ sender: Any) {
        handleRegister()
        
    }
    @IBAction func LoginAction(_ sender: Any) {
        handleLogin()
    }
    
//    func setupRegisterButton() {
//        setupRegisterButton().centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        setupRegisterButton().bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
//        setupRegisterButton().widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
//        setupRegisterButton().heightAnchor.constraint(equalToConstant: 30).isActive = true
//    }
    
    
    
    
//    func setupLoginButton() {
//        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        loginButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
//        loginButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
//        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }
    
    // MARK: - Action handler
    
    @objc func resignKeyboard() {
        EmailTextField.resignFirstResponder()
        PasswordTextField.resignFirstResponder()
    }
    
    @objc func handleLogin() {
       
        
        EmailTextField.resignFirstResponder()
        PasswordTextField.resignFirstResponder()
        
        guard let email = EmailTextField.text, let password = PasswordTextField.text
            else {
                fatalError("textfield is nil")
        }
        
        if EmailTextField.text == "" {
            EmailTextField.shake(2, withDelta: 4, speed: 0.07)
            EmailTextField.attributedPlaceholder = NSAttributedString(string: "Email cannot be empty", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        
        if PasswordTextField.text == "" {
            PasswordTextField.shake(2, withDelta: 4, speed: 0.07)
            PasswordTextField.attributedPlaceholder = NSAttributedString(string: "Password cannot be empty", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        
        if (EmailTextField.text == "") || (PasswordTextField.text == "") {
            
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if user != nil{
                print(user)
            }
            if error != nil {
                debugPrint(error)
                
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .invalidEmail:
                        self.EmailTextField.shake(2, withDelta: 4, speed: 0.07)
                        self.EmailTextField.text = ""
                        self.PasswordTextField.text = ""
                        self.EmailTextField.attributedPlaceholder = NSAttributedString(string: "🌚 Email address is invalid", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    case .userNotFound:
                        self.EmailTextField.shake(2, withDelta: 4, speed: 0.07)
                        self.EmailTextField.text = ""
                        self.PasswordTextField.text = ""
                        self.EmailTextField.attributedPlaceholder = NSAttributedString(string: "🌚 Account doesn't exist", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    case .wrongPassword:
                        self.PasswordTextField.shake(2, withDelta: 4, speed: 0.07)
                        self.PasswordTextField.text = ""
                        self.PasswordTextField.attributedPlaceholder = NSAttributedString(string: "🌚 The password is incorrect", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                    default:
                        self.EmailTextField.shake(2, withDelta: 4, speed: 0.07)
                        self.PasswordTextField.shake(2, withDelta: 4, speed: 0.07)
                        self.EmailTextField.text = ""
                        self.PasswordTextField.text = ""
                    }
                }
               
                return
            }
            
            // Ask for registor remote notification
            self.CheckUser()
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            //            appDelegate.registerRemoteNotification(UIApplication.shared)
//
//            //            self.messageController?.fetchUserAndSetupNavBarTitle()
//            self.dismiss(animated: true, completion: {
//            })
        }
    }
    func CheckUser(){
        db = Firestore.firestore()
        
        let dealsRef = db.collection("user").document(Auth.auth().currentUser?.uid ?? "")
        dealsRef.addSnapshotListener { (snapshot, error) in
            guard let doc = snapshot, let dic = doc.data() else {
                print(error)
                return
            }
            if let name = dic["Type"] as? String{
                print("Type.....................", name)
                if name == "Merchant"{
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    appDelegate.registerRemoteNotification(UIApplication.shared)
                    
                    self.dismiss(animated: true, completion: {
                        
                    })
                }
                else{
                    self.alert(message: "User is not registered with this app try login with customer")
//                    self.loginButton.hideLoading()
                    self.handleLogout()
                }
                
            } else {
                self.alert(message: "User is not registered with this app try login with customer")
//                self.loginButton.hideLoading()
                self.handleLogout()
            }
            //            if let email = Auth.auth().currentUser?.email{
            //                self.emailCell.textLabel?.text = email
            //            } else {
            //                self.emailCell.textLabel?.text = "N/A"
            //            }
        }
    }
    
    @objc func handleLogout() {
        do {
            if let uid = Auth.auth().currentUser?.uid {
//             Firestore.firestore().collection("user").document(uid).
                print("Deleted user past token")
                
            } else {
                print("No user token have to be deleted")
            }
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        //        let loginController = LoginViewController()
        
        let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        let navController = UINavigationController(rootViewController: loginController)
        navController.navigationBar.barStyle = .blackTranslucent
        present(navController, animated: true)
    }
    
    @objc func handleRegister() {
//        let registerController = SignUpVC()
//        //        registerController.messageController = messageController
//        navigationController?.pushViewController(registerController, animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
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
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let maxYButton = LoginButton.frame.maxY + 12
            let maxYKeyboard = SCREEN_HEIGHT - keyboardHeight
            if maxYButton > maxYKeyboard {
                UIView.animate(withDuration: keyboardDuration!, animations: {
                    self.view.frame.origin.y = maxYKeyboard - maxYButton
                })
            }
        } else {
            UIView.animate(withDuration: keyboardDuration!, animations: {
                self.view.frame.origin.y = -100
            })
        }
    }
    
    @objc func handleKeyboardWillHide(_ notification: Notification) {
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.frame.origin.y = 0
        })
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
}
