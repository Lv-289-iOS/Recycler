//
//  RCLIssuesCell.swift
//  Recycler
//
//  Created by Roman Shveda on 3/13/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit

class RCLIssuesCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
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
            sizeName = "S"
        case 2:
            sizeName = "M"
        case 3:
            sizeName = "L"
        case 4:
            sizeName = "XL"
        default:
            sizeName = "M"
        }
        self.location.text = data.1.address
        self.size.text = sizeName
        self.phoneNumber.text = data.2.phoneNumber
    }
    
    func colorsSetup() {
        viewContainer.backgroundColor = UIColor.Backgrounds.GrayLight
        location.textColor = UIColor.Font.Gray
        size.textColor = UIColor.Font.White
        viewContainer.layer.cornerRadius = CGFloat.Design.CornerRadius
        size.textColor = UIColor.Font.White
        backgroundColor = UIColor.clear
    }
    
}
