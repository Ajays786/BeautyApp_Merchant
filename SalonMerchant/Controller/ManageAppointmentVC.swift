//
//  ManageAppointmentVC.swift
//  SalonMerchant
//
//  Created by Sagar Midha on 5/17/19.
//  Copyright © 2019 刘恒宇. All rights reserved.
//
import Foundation
import UIKit
import ImageSlideshow
import FirebaseFirestore
import FirebaseAuth
class ManageAppointmentVC: BaseViewController
{
    @IBOutlet weak var SlideShow: ImageSlideshow!
    @IBOutlet var vW: UIView!
    @IBOutlet weak var tableView: UITableView!
      var db: Firestore!
    var deals: [AppointmentModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        
        self.navigationItem.title = "Manage Appointments"
        
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
        loadTable()
    }
    func loadTable() {
        db = Firestore.firestore()
        
        let dealsRef = db.collection("reservation")
        dealsRef.addSnapshotListener { (snapshot, error) in
            guard let doc = snapshot else {
                print(error!)
                return
            }
            for change in doc.documentChanges {
                print(change.document.data())
                let temDeal = AppointmentModel(data: change.document.data())
                self.deals.append(temDeal)
               
            }
        }
    }
}

extension ManageAppointmentVC: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return deals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ManageAppointmentTableViewCell
        print(deals[indexPath.row].Services)
        print(deals[indexPath.row].uid)
        print(deals[indexPath.row].status)
        print(deals[indexPath.row].Date)
        print(deals[indexPath.row].Time)
        print(deals[indexPath.row].MilesAway)
        print(deals[indexPath.row].Price)
        print(deals[indexPath.row].Zip)
//        cell.nameLbl.text = Auth.auth().
        cell.nameLbl.text = "Name - " + deals[indexPath.row].Name
        cell.dateTimeLbl.text = "Time and Date -" + deals[indexPath.row].Time + " " + deals[indexPath.row].Date
        if deals[indexPath.row].status == true{
          cell.statusLbl.text = "Status - Active"
        }
        else{
            cell.statusLbl.text = "Status - In-Active"
        }
            cell.servicesLbl.text? = "Services - " + deals[indexPath.row].Services.joined(separator: ",")
        return cell
        
    }
    
    
}
