//
//  CustomMesageCell.swift
//  SalonMerchant
//
//  Created by Sagar Midha on 5/20/19.
//  Copyright © 2019 刘恒宇. All rights reserved.
//

import UIKit

class CustomMesageCell: UITableViewCell
{
    @IBOutlet weak var myImgVw: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var messagePreviewLbl: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
}
