//
//  ViewRequestsVC.swift
//  SalonMerchant
//
//  Created by Sagar Midha on 5/15/19.
//  Copyright © 2019 刘恒宇. All rights reserved.
//

import UIKit
import ImageSlideshow

class ViewRequestsVC: UIViewController, UIScrollViewDelegate
{
    @IBOutlet weak var contentVw: UIView!
    
    @IBOutlet weak var SlideShow: ImageSlideshow!
    @IBOutlet weak var sendBtn: UIButton!
    //Mark: ContentData Primary
    @IBOutlet weak var dataContentVw1: UIView!
    @IBOutlet weak var content1NameLbl: UILabel!
    @IBOutlet weak var content1ServiceLbl: UILabel!
    @IBOutlet weak var content1TimeDateLbl: UILabel!
    @IBOutlet weak var content1MakeOfferBtn: UIButton!
    
    //Mark: Content Data Secondary
    @IBOutlet weak var dataContentVw2: UIView!
    @IBOutlet weak var content2NameLbl: UILabel!
    @IBOutlet weak var content2ServiceLbl: UILabel!
    @IBOutlet weak var content2TimeDateLbl: UILabel!
    @IBOutlet weak var content2MakeOfferBtn: UIButton!
    
    
    
    
    
    var imagArray: [String] = ["","",""]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dataContentVw1.layer.cornerRadius = 5
        dataContentVw2.layer.cornerRadius = 5
        content1MakeOfferBtn.layer.cornerRadius = 5
        content2MakeOfferBtn.layer.cornerRadius = 5
        sendBtn.layer.cornerRadius = 25
        self.navigationItem.title = "View Requests"
        self.navigationController?.navigationBar.topItem?.title = " "
        
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
        
    }
    
    @IBAction func sendBtn(_ sender: Any)
    {
        
    }

}

