//
//  RCLTakenCell.swift
//  Recycler
//
//  Created by Ostin Ostwald on 3/13/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit

class RCLTakenCell: UITableViewCell {
   
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    var data = (Trash(),TrashCan(),User())
    
    func configureCell(forData: (Trash,TrashCan,User)) {
        colorsSetup()
       self.data = forData
      
        switch data.1.type {
        case "plastic" :
            self.icon.image = #imageLiteral(resourceName: "trash_plastic")
        case "metal" :
            self.icon.image = #imageLiteral(resourceName: "trash_metal")
        case "organic" :
            self.icon.image = #imageLiteral(resourceName: "trash_organic")
        case "battaries" :
            self.icon.image = #imageLiteral(resourceName: "battery")
        default:
            self.icon.image = #imageLiteral(resourceName: "trash_other")
        }
        var sizeName = ""
        switch data.1.size {
        case 1:
            sizeName = "small"
        case 2:
            sizeName = "medium"
        case 3:
            sizeName = "large"
        case 4:
            sizeName = "extraL"
        default:
            sizeName = "medium"
        }
        self.userName.text = data.0.userIdReportedFull
        self.location.text = data.1.address
        self.size.text = sizeName
        self.phone.text = data.2.phoneNumber
   
    }
    func colorsSetup() {
//        btn.backgroundColor = UIColor.Backgrounds.GrayLight
//        name.textColor = UIColor.Font.White
        location.textColor = UIColor.Font.Gray
        size.textColor = UIColor.Font.White
        viewContainer.layer.cornerRadius = CGFloat.Design.CornerRadius
        
        backgroundColor = UIColor.Backgrounds.GrayDark
    }
    
}
