//
//  HappyHourVC.swift
//  SalonMerchant
//
//  Created by Sagar Midha on 5/16/19.
//  Copyright © 2019 刘恒宇. All rights reserved.
//

import UIKit
import ImageSlideshow
import FirebaseFirestore
import Firebase
import DateTimePicker
class HappyHourVC: BaseViewController,UITextFieldDelegate,UITextViewDelegate,DateTimePickerDelegate
{
    //Mark: Outlets
    var Services = [String]()
    @IBOutlet weak var SlideShow: ImageSlideshow!
     lazy var functions = Functions.functions()
    var left = 0
    var Right = 0
    let BeutySpecilaColor = UIColor(r:108,g:25,b:170)
    var db: Firestore!
//    lazy var functions = Functions.functions()
    @IBOutlet weak var HairBtn: UIButton!
    @IBOutlet weak var SpaBtn: UIButton!
    @IBOutlet weak var NailsBtn: UIButton!
    @IBOutlet weak var TanningBtn: UIButton!
    @IBOutlet weak var EnterDistanceText: UITextField!
    @IBOutlet weak var ZipText: UITextField!
    @IBOutlet weak var NotificationBtn: UIButton!
    @IBOutlet weak var DogGrommingBtn: UIButton!
    @IBOutlet weak var NoticationSwitchBtn: UISwitch!
    
    @IBOutlet weak var SkinCareBtn: UIButton!
    @IBOutlet weak var WaxBtn: UIButton!
    @IBOutlet weak var EyelashBtn: UIButton!
    @IBOutlet weak var EyebrowBrn: UIButton!
    @IBOutlet weak var MakeupBtn: UIButton!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var TimeDateButton: UIButton!
    
    @IBOutlet weak var ServiceOfferedTextViewDescription: UITextView!
    @IBOutlet weak var RegularPriceText: UITextField!
    @IBOutlet weak var PromoPriceText: UITextField!
    @IBOutlet weak var TotalDiscountText: UITextField!
    var Name = ""
    
    override func viewDidLoad(){
        super.viewDidLoad()
        ServiceOfferedTextViewDescription.textColor =  UIColor.lightGray
        ServiceOfferedTextViewDescription.text = "Type in Ad here. Minimum 200 Charecters."
        let localSource = [ImageSource(imageString: "Image_dryer")!, ImageSource(imageString: "Image_lip")!, ImageSource(imageString: "WaxingImage")!,  ImageSource(imageString: "Hair - Beauty shot 1 for")!,ImageSource(imageString: "DogImage")! ,ImageSource(imageString: "FacialImage")!]
        SlideShow.slideshowInterval = 5.0
        SlideShow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        SlideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor(r:108,g:25,b:170)
        SlideShow.pageIndicator = pageControl
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        SlideShow.activityIndicator = DefaultActivityIndicator()
        //        ImageSlideShow.delegate = self
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        SlideShow.setImageInputs(localSource)
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //
        let Insets:CGFloat = 8.0
        HairBtn.contentVerticalAlignment = .fill
        HairBtn.contentHorizontalAlignment = .fill
        HairBtn.imageEdgeInsets = UIEdgeInsets(top: Insets, left: Insets, bottom: Insets, right: Insets)
        
        SpaBtn.contentVerticalAlignment = .fill
        SpaBtn.contentHorizontalAlignment = .fill
        SpaBtn.imageEdgeInsets = UIEdgeInsets(top: Insets, left: Insets, bottom: Insets, right: Insets)
        
        NailsBtn.contentVerticalAlignment = .fill
        NailsBtn.contentHorizontalAlignment = .fill
        NailsBtn.imageEdgeInsets = UIEdgeInsets(top: Insets, left: Insets, bottom: Insets, right: Insets)
        
        TanningBtn.contentVerticalAlignment = .fill
        TanningBtn.contentHorizontalAlignment = .fill
        TanningBtn.imageEdgeInsets = UIEdgeInsets(top: Insets, left: Insets, bottom: Insets, right: Insets)
        
        DogGrommingBtn.contentVerticalAlignment = .fill
        DogGrommingBtn.contentHorizontalAlignment = .fill
        DogGrommingBtn.imageEdgeInsets = UIEdgeInsets(top: Insets, left: Insets, bottom: Insets, right: Insets)
        
        SkinCareBtn.contentVerticalAlignment = .fill
        SkinCareBtn.contentHorizontalAlignment = .fill
        SkinCareBtn.imageEdgeInsets = UIEdgeInsets(top: Insets, left: Insets, bottom: Insets, right: Insets)
        
        EyebrowBrn.contentVerticalAlignment = .fill
        EyebrowBrn.contentHorizontalAlignment = .fill
        EyebrowBrn.imageEdgeInsets = UIEdgeInsets(top: Insets, left: Insets, bottom: Insets, right: Insets)
        
        EyelashBtn.contentVerticalAlignment = .fill
        EyelashBtn.contentHorizontalAlignment = .fill
        EyelashBtn.imageEdgeInsets = UIEdgeInsets(top: Insets, left: Insets, bottom: Insets, right: Insets)
        
        WaxBtn.contentVerticalAlignment = .fill
        WaxBtn.contentHorizontalAlignment = .fill
        WaxBtn.imageEdgeInsets = UIEdgeInsets(top: Insets, left: Insets, bottom: Insets, right: Insets)
        
        MakeupBtn.contentVerticalAlignment = .fill
        MakeupBtn.contentHorizontalAlignment = .fill
        MakeupBtn.imageEdgeInsets = UIEdgeInsets(top: Insets, left: Insets, bottom: Insets, right: Insets)
        getName()
        
    }
    
    //Mark: Actions
    func deselectServices(){
        //HairBtn button
        HairBtn.setImage(UIImage(named: "hair-grey"), for: .normal)
        HairBtn.backgroundColor = UIColor.white
         //SpaBtn button
        SpaBtn.setImage(UIImage(named: "spa-grey"), for: .normal)
        SpaBtn.backgroundColor = UIColor.white
         //NailsBtn button
        NailsBtn.setImage(UIImage(named: "nail-gey"), for: .normal)
        NailsBtn.backgroundColor = UIColor.white
         //TanningBtn button
        TanningBtn.setImage(UIImage(named: "tanning-grey"), for: .normal)
        TanningBtn.backgroundColor = UIColor.white
         //DogGrommingBtn button
        DogGrommingBtn.setImage(UIImage(named: "Dog-grey"), for: .normal)
        DogGrommingBtn.backgroundColor = UIColor.white
         //SkinCareBtn button
        SkinCareBtn.setImage(UIImage(named: "Skin-grey"), for: .normal)
        SkinCareBtn.backgroundColor = UIColor.white
         //WaxBtn button
        WaxBtn.setImage(UIImage(named: "wax-grey"), for: .normal)
        WaxBtn.backgroundColor = UIColor.white
         //EyelashBtn button
        EyelashBtn.setImage(UIImage(named: "eyelash-grey"), for: .normal)
        EyelashBtn.backgroundColor = UIColor.white
         //EyebrowBrn button
        EyebrowBrn.setImage(UIImage(named: "Eyebrow-grey"), for: .normal)
        EyebrowBrn.backgroundColor = UIColor.white
         //MakeupBtn button
        MakeupBtn.setImage(UIImage(named: "make_up-grey"), for: .normal)
        MakeupBtn.backgroundColor = UIColor.white
        self.Services.removeAll()
    }
    @IBAction func HairAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "hair-grey"){
            sender.setImage(UIImage(named: "hair"), for: .normal)
            sender.backgroundColor = self.BeutySpecilaColor
            self.Services.appendUniqueObject(object:"Hair")
        }
        else if sender.currentImage ==  UIImage(named: "hair"){
            sender.setImage(UIImage(named: "hair-grey"), for: .normal)
            sender.backgroundColor = UIColor.white
            self.Services.index(of:"Hair").map{self.Services.remove(at: $0)}
        }
    }
    @IBAction func SpaAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "spa-grey"){
            sender.setImage(UIImage(named: "spa"), for: .normal)
            sender.backgroundColor = self.BeutySpecilaColor
            self.Services.appendUniqueObject(object:"Spa")
        }
        else if sender.currentImage ==  UIImage(named: "spa"){
            sender.setImage(UIImage(named: "spa-grey"), for: .normal)
            sender.backgroundColor = UIColor.white
            self.Services.index(of:"Spa").map{self.Services.remove(at: $0)}
        }
        
    }
    @IBAction func NailsAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "nail-gey"){
            sender.setImage(UIImage(named: "nailpaint"), for: .normal)
            sender.backgroundColor = self.BeutySpecilaColor
            self.Services.appendUniqueObject(object:"Nails")
            
        }
        else if sender.currentImage ==  UIImage(named: "nailpaint"){
            sender.setImage(UIImage(named: "nail-gey"), for: .normal)
            sender.backgroundColor = UIColor.white
            self.Services.index(of:"Nails").map{self.Services.remove(at: $0)}
        }
    }
    @IBAction func TanningAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "tanning-grey"){
            sender.setImage(UIImage(named: "tanning"), for: .normal)
            sender.backgroundColor = self.BeutySpecilaColor
            self.Services.appendUniqueObject(object:"Tanning")
            
        }
        else if sender.currentImage ==  UIImage(named: "tanning"){
            sender.setImage(UIImage(named: "tanning-grey"), for: .normal)
            sender.backgroundColor = UIColor.white
            self.Services.index(of:"Tanning").map{self.Services.remove(at: $0)}
        }
    }
    
    @IBAction func NotidicationAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "notification-grey"){
            sender.setImage(UIImage(named: "notifications"), for: .normal)
            
        }
        else if sender.currentImage ==  UIImage(named: "notifications"){
            sender.setImage(UIImage(named: "notification-grey"), for: .normal)
            
            
        }
        
        
    }

    @IBAction func DogGrommingAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "Dog-grey"){
            sender.setImage(UIImage(named: "Dog"), for: .normal)
            sender.backgroundColor = self.BeutySpecilaColor
            self.Services.appendUniqueObject(object: "Dog Grooming")
            
        }
        else if sender.currentImage ==  UIImage(named: "Dog"){
            sender.setImage(UIImage(named: "Dog-grey"), for: .normal)
            sender.backgroundColor = UIColor.white
            self.Services.index(of:"Dog Grooming").map{self.Services.remove(at: $0)}
            
        }
        
    }
    @IBAction func SkinCareAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "Skin-grey"){
            sender.setImage(UIImage(named: "Skin"), for: .normal)
            sender.backgroundColor = self.BeutySpecilaColor
            self.Services.appendUniqueObject(object: "Skin Care")
            
        }
        else if sender.currentImage ==  UIImage(named: "Skin"){
            sender.setImage(UIImage(named: "Skin-grey"), for: .normal)
            sender.backgroundColor = UIColor.white
            self.Services.index(of:"Skin Care").map{self.Services.remove(at: $0)}
            
        }
        
    }
    @IBAction func WaxAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "wax-grey"){
            sender.setImage(UIImage(named: "wax"), for: .normal)
            sender.backgroundColor = self.BeutySpecilaColor
            self.Services.appendUniqueObject(object: "Wax")
            
        }
        else if sender.currentImage ==  UIImage(named: "wax"){
            sender.setImage(UIImage(named: "wax-grey"), for: .normal)
            sender.backgroundColor = UIColor.white
            self.Services.index(of:"Wax").map{self.Services.remove(at: $0)}
            
        }
        
    }
    @IBAction func EyelashAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "eyelash-grey"){
            sender.setImage(UIImage(named: "eyelash"), for: .normal)
            sender.backgroundColor = self.BeutySpecilaColor
            self.Services.appendUniqueObject(object: "Eyelash")
            
        }
        else if sender.currentImage ==  UIImage(named: "eyelash"){
            sender.setImage(UIImage(named: "eyelash-grey"), for: .normal)
            sender.backgroundColor = UIColor.white
            self.Services.index(of:"Eyelash").map{self.Services.remove(at: $0)}
            
        }
        
    }
    @IBAction func EyebroAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "Eyebrow-grey"){
            sender.setImage(UIImage(named: "Eyebrow"), for: .normal)
            sender.backgroundColor = self.BeutySpecilaColor
            self.Services.appendUniqueObject(object: "Eyebrow")
            
        }
        else if sender.currentImage ==  UIImage(named: "Eyebrow"){
            sender.setImage(UIImage(named: "Eyebrow-grey"), for: .normal)
            sender.backgroundColor = UIColor.white
            self.Services.index(of:"Eyebrow").map{self.Services.remove(at: $0)}
            
        }
        
    }
    @IBAction func MakeupAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "make_up-grey"){
            sender.setImage(UIImage(named: "make_up"), for: .normal)
            sender.backgroundColor = self.BeutySpecilaColor
            self.Services.appendUniqueObject(object: "Make Up")
            
        }
        else if sender.currentImage ==  UIImage(named: "make_up"){
            sender.setImage(UIImage(named: "make_up-grey"), for: .normal)
            sender.backgroundColor = UIColor.white
            self.Services.index(of:"Make Up").map{self.Services.remove(at: $0)}
            
        }
        
    }
    
    @IBAction func SendToCommunityAction(_ sender: Any) {
        if TimeDateButton.currentTitle == "Time & Date"{
            self.alert(message: "Please select time and date")
        }
        else if Services.count == 0{
            self.alert(message: "Please select any category")
        }
        else if ServiceOfferedTextViewDescription.text == "Type in Ad here. Minimum 200 Charecters."{
            self.alert(message: "Please type an ad")
        }
        else if RegularPriceText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            self.alert(message: "Please enter regular price")
        }
        else if PromoPriceText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            self.alert(message: "Please enter promo price")
        }
        else{
        var actions: [(String, UIAlertAction.Style)] = []
        actions.append(("Purchase Now - $4.99﻿", UIAlertAction.Style.default))
        actions.append(("Cancel", UIAlertAction.Style.destructive))
        
        //self = ViewController
        Alerts.showActionsheet(viewController: self, title: "By hitting the button below you will send out your Beauty Match offer to all potential clients in your area. ", message: "", actions: actions) { (index) in
            print("call action \(index)")
            switch (index){
            case 0:
                print("Save")
                self.db = Firestore.firestore()
            let par: [String: AnyObject] = [
                "TimeDate": self.TimeDateButton.currentTitle as AnyObject,
                "Services": self.Services as AnyObject,
                "ServiceOffered": self.ServiceOfferedTextViewDescription.text as AnyObject,
                "RegularPrice": self.RegularPriceText.text as AnyObject,
                "PromoPrice": self.PromoPriceText.text as AnyObject,
                "TotalDiscount": self.TotalDiscountText.text as AnyObject,
                "Name": self.Name as AnyObject,
            ]
                self.functions.httpsCallable("beautymatch").call(par) { _, err in
                // Ignore errors for now
                if err != nil{
                    print("error", err)
                }
                    self.alert(message: "Sent Successfully")
                print("Successful..................Added offer")
                self.TimeDateButton.setTitle("Time & Date", for: .normal)
                    self.deselectServices()
                    self.ServiceOfferedTextViewDescription.text = "Type in Ad here. Minimum 200 Charecters."
                    self.ServiceOfferedTextViewDescription.textColor = UIColor.lightGray
                    self.RegularPriceText.text = ""
                    self.PromoPriceText.text = ""
                    self.TotalDiscountText.text = ""
                return
                }
            case 1:
                self.dismiss(animated: true, completion: nil)
            default: break
                
            }
        }
        }
    }
    func getName(){
        db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            //            handleLogout()
            return
        }
        db.collection("user").document(uid).addSnapshotListener { (snap, err) in
            guard err == nil, let name = snap?.data()?["name"] as? String else {
                print(err)
                self.Name = "Error"
                return
            }
            self.Name = name
    }
    }
    
    @IBAction func DateTimePickerButton(_ sender: Any) {
        let min = Date()
        let max = Date().addingTimeInterval(60 * 60 * 24 * 365)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        picker.frame = CGRect(x: 0, y: 100, width: picker.frame.size.width, height: picker.frame.size.height)
        picker.highlightColor = self.BeutySpecilaColor
        picker.dateFormat = "h:mm a MM/dd/yyyy"
        picker.includeMonth = true
        picker.timeZone = .current
        picker.is12HourFormat = true
        picker.doneBackgroundColor = self.BeutySpecilaColor
        //        picker.in
        picker.delegate = self
        
        //         picker.donePicking()
        picker.show()
    }
    
    //Mark: All Delegates
    
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        let Date = picker.selectedDateString
      self.TimeDateButton.setTitle(Date, for: .normal)
        
        
    }
    func CalculateDiscount(RegularPrice:String,PromoPrice:String) ->Double{
        let RP = Double(RegularPrice) ?? 0.0
        let PP = Double(PromoPrice) ?? 0.0
        let Discount = PP/RP*100
        return 100-Discount
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return textView.text.count + (text.count - range.length) <= 200
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type in Ad here. Minimum 200 Charecters."
            textView.textColor = UIColor.lightGray
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if RegularPriceText.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && PromoPriceText.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
            let discount =  self.CalculateDiscount(RegularPrice: RegularPriceText.text!, PromoPrice: PromoPriceText.text!)
            TotalDiscountText.text = String(discount)
            print("Discount1.....................", discount)
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
            if RegularPriceText.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && PromoPriceText.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
               let discount =  self.CalculateDiscount(RegularPrice: RegularPriceText.text!, PromoPrice: PromoPriceText.text!)
                TotalDiscountText.text = String(discount)
                print("Discount.....................", discount)
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if textField == RegularPriceText{
            if RegularPriceText.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && PromoPriceText.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
                let discount =  self.CalculateDiscount(RegularPrice: RegularPriceText.text!, PromoPrice: PromoPriceText.text!)
                TotalDiscountText.text = String(discount)
            }
        }
        if textField == PromoPriceText{
            if RegularPriceText.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && PromoPriceText.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
                let discount =  self.CalculateDiscount(RegularPrice: RegularPriceText.text!, PromoPrice: PromoPriceText.text!)
                TotalDiscountText.text = String(discount)
            }
        }
        let numberOnly = NSCharacterSet.init(charactersIn: ".0123456789")
        let stringFromTextField = NSCharacterSet.init(charactersIn: string)
        let strValid = numberOnly.isSuperset(of: stringFromTextField as CharacterSet)
        return strValid
    }
    
}

