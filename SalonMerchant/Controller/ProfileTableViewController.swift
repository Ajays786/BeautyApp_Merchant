//
//  ProfileTableViewController.swift
//  SalonMerchant
//
//  Created by Sagar Midha on 5/15/19.
//  Copyright © 2019 刘恒宇. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import CoreLocation
class ProfileTableViewController: BaseViewController,CLLocationManagerDelegate{
    //Mark: Outlets
      var db: Firestore!
    var locationManager = CLLocationManager()
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var showRequestBtn: UIButton!
    @IBOutlet weak var checkHappyHourBtn: UIButton!
    @IBOutlet weak var manageAppointmentBtn: UIButton!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var LogOutBtn: LoadingButton!
    @IBOutlet weak var LogOut: LoadingButton!
    
    @IBOutlet weak var profileImageView: UIImageView!{
        didSet{
            loadUserProfile()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        borderAndCornerRadiusSet()
        checkIfUserIsLoggedIn()
         self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2
          locationManager.requestWhenInUseAuthorization()
         locationManager.requestAlwaysAuthorization()
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            print("startUpdatingLocation...............")
            let myLocation = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
            let dealsRef = db.collection("user").document(Auth.auth().currentUser?.uid ?? "")
            dealsRef.updateData(["lat": "\(myLocation.coordinate.latitude)" as Any, "long": "\(myLocation.coordinate.longitude)" as Any])
        }
       
        
        

    }
    
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            // add delay to solve the warning message "Unbalanced calls to begin"
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            // Ask for registor remote notification
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.registerRemoteNotification(UIApplication.shared)
           
        }
    }
    func CalculateDistance(MyLocation:CLLocation, MybuddyLocation:CLLocation)->CLLocationDistance{
        
        let Distance =  MyLocation.distance(from: MybuddyLocation).inMiles()
        
        return Distance
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let location = locations.last! as CLLocation
        print("location is updating.........")
        /* you can use these values*/
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        //My location
        let myLocation = CLLocation(latitude: lat, longitude: long)
        let dealsRef = db.collection("user").document(Auth.auth().currentUser?.uid ?? "")
        dealsRef.updateData(["lat": "\(myLocation.coordinate.latitude)" as Any, "long": "\(myLocation.coordinate.longitude)" as Any])
        
//        let dealsRef = db.collection("user").document(Auth.auth().currentUser?.uid ?? "")
//        dealsRef.updateData(["location": myLocation as Any])
        
        //My buddy's location
//        let myBuddysLocation = CLLocation(latitude: 25.439420, longitude: 81.847633)
//
//        //Measuring my distance to my buddy's (in km)
//        //        let distance = myLocation.distance(from: myBuddysLocation)
//
//        let Distnace = CalculateDistance(MyLocation: myLocation, MybuddyLocation: myBuddysLocation)
//        //Display the result in km
//        print(String(format: "The distance to my buddy is %.01f miles", Distnace))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadUserProfile()
    }
    //Mark: Edit profile Button
    @IBAction func editProfileBtn(_ sender: Any)
    {
        let editProfileVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileviewController") as! ProfileviewController
        editProfileVC.name = NameLabel.text!
        editProfileVC.Profile = profileImageView.image ?? UIImage(named: "profile")!
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    //Mark: View Request Button
    
    @IBAction func viewRequestsBtn(_ sender: Any)
    {
        let viewRequestVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewRequestsVC") as? ViewRequestsVC
        self.navigationController?.pushViewController(viewRequestVC!, animated: true)
    }
    //Mark: Happy Hour & Happy Hour Continue Screen
    @IBAction func happyHourBtn(_ sender: Any)
    {
        let happyHourVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HappyHourVC") as? HappyHourVC
        self.navigationController?.pushViewController(happyHourVC!, animated: true)

    }
    //Mark: Manage Appointment
    
    @IBAction func mangeAppointmentBtn(_ sender: Any)
    {
        let manageAppointmentVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageAppointmentVC") as? ManageAppointmentVC
        self.navigationController?.pushViewController(manageAppointmentVC!, animated: true)
    }
    
    //Mark: Set Border & Corner Radius
    func borderAndCornerRadiusSet()
    {
//        self.editProfileBtn.layer.cornerRadius = self.editProfileBtn.frame.width / 10
//        self.showRequestBtn.layer.cornerRadius = self.showRequestBtn.frame.width / 10
//        self.checkHappyHourBtn.layer.cornerRadius = self.checkHappyHourBtn.frame.width / 10
//        self.manageAppointmentBtn.layer.cornerRadius = self.manageAppointmentBtn.frame.width / 10

        editProfileBtn.layer.shadowColor = UIColor.white.cgColor
        editProfileBtn.layer.shadowOffset = CGSize(width: 2, height:2)
        editProfileBtn.layer.shadowRadius = 5
        editProfileBtn.layer.cornerRadius = editProfileBtn.frame.height/2
        editProfileBtn.layer.shadowOpacity = 5.0
//        showRequestBtn.layer.cornerRadius = 25
        LogOutBtn.layer.shadowColor = UIColor.white.cgColor
        LogOutBtn.layer.shadowOffset = CGSize(width: 2, height:2)
        LogOutBtn.layer.shadowRadius = 5
        LogOutBtn.layer.cornerRadius = LogOutBtn.frame.height/2
        LogOutBtn.layer.shadowOpacity = 5.0
        
        LogOut.layer.shadowColor = UIColor.white.cgColor
        LogOut.layer.shadowOffset = CGSize(width: 2, height:2)
        LogOut.layer.shadowRadius = 5
        LogOut.layer.cornerRadius = LogOutBtn.frame.height/2
        LogOut.layer.shadowOpacity = 5.0
        
        checkHappyHourBtn.layer.shadowColor = UIColor.white.cgColor
        checkHappyHourBtn.layer.shadowOffset = CGSize(width: 2, height:2)
        checkHappyHourBtn.layer.shadowRadius = 5
        checkHappyHourBtn.layer.cornerRadius = checkHappyHourBtn.frame.height/2
        checkHappyHourBtn.layer.shadowOpacity = 5.0
      
        manageAppointmentBtn.layer.shadowColor = UIColor.white.cgColor
        manageAppointmentBtn.layer.shadowOffset = CGSize(width: 2, height:2)
        manageAppointmentBtn.layer.shadowRadius = 5
        manageAppointmentBtn.layer.cornerRadius = manageAppointmentBtn.frame.height/2
        manageAppointmentBtn.layer.shadowOpacity = 5.0
    }
    @IBAction func LogOutAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func NotificationAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func handlelogout(_ sender: Any) {
        handleLogout()
    }
    
    @objc func handleLogout() {
        do {
            if let uid = Auth.auth().currentUser?.uid {
                Database.database().reference().child("users").child(uid).child("token").removeValue()
                print("Deleted user past token")
            } else {
                print("No user token have to be deleted")
            }
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }

        //        let loginController = LoginViewController()
        //        let navController = UINavigationController(rootViewController: loginController)
        ////        navController.navigationBar.barStyle = .blackTranslucent
        //        present(navController, animated: true)
        let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

        let navController = UINavigationController(rootViewController: loginController)
        navController.navigationBar.barStyle = .blackTranslucent
        present(navController, animated: true)
        
    }
    func loadUserProfile() {
        db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            //            handleLogout()
            return
        }
        db.collection("user").document(uid).addSnapshotListener { (snap, err) in
            guard err == nil, let name = snap?.data()?["name"] as? String else {
                print(err)
                self.NameLabel.text = "Error"
                return
            }
            self.NameLabel.text = name
            if let image = snap?.data()?["icon"] as? String {
                var ref = Storage.storage().reference(withPath: "profile_images")
                ref = ref.child(image+".png")
                ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                    } else {
                        let imageV = UIImage(data: data!)
                        self.profileImageView.image = imageV
                    }
                }
            }
        }
    }
}
