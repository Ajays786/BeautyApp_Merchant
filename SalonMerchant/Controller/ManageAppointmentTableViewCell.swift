//
//  ManageAppointmentTableViewCell.swift
//  SalonMerchant
//
//  Created by Rahul Tiwari on 5/30/19.
//  Copyright © 2019 刘恒宇. All rights reserved.
//

import UIKit

class ManageAppointmentTableViewCell: UITableViewCell
{
    @IBOutlet weak var userDataCellView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var servicesLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var denyBtn: UIButton!
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
         setCorner()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCorner()
    {
        
        acceptBtn.layer.cornerRadius = 15
        denyBtn.layer.cornerRadius = 15
    }
}
