

import Foundation
import UIKit
import ImageSlideshow

class HourContinueVC: UIViewController
{
    
    
    @IBOutlet weak var SlideShow: ImageSlideshow!
    @IBOutlet var vW: UIView!
    @IBOutlet weak var regularPriceLbl: UILabel!
    @IBOutlet weak var regularPriceTxtFld: UITextField!
    @IBOutlet weak var promoPriceLbl: UILabel!
    @IBOutlet weak var promoPriceTxtFld: UITextField!
    @IBOutlet weak var totalDiscountLbl: UILabel!
    @IBOutlet weak var totalDiscoutnTxtFld: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setCorner()
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
    func setCorner()
    {
        sendBtn.layer.cornerRadius = 25
        regularPriceTxtFld.layer.cornerRadius = 5
        promoPriceTxtFld.layer.cornerRadius = 5
        totalDiscoutnTxtFld.layer.cornerRadius = 5
        vW.layer.cornerRadius = 5
    }
}
