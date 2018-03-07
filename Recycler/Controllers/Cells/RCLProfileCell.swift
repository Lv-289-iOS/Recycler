//
//  RCLProfileCell.swift
//  Recycler
//
//  Created by David on 3/6/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit

class RCLProfileCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    var trashCan: TrashCan?
    
    func configureCell(forCan: TrashCan) {
        colorsSetup()
        self.trashCan = forCan
        switch forCan.type {
        case "plastic" :
            self.icon.image = #imageLiteral(resourceName: "trash_plastic")
        case "metal" :
            self.icon.image = #imageLiteral(resourceName: "trash_metal")
        case "organic" :
            self.icon.image = #imageLiteral(resourceName: "trash_organic")
        case "battaries" :
            self.icon.image = #imageLiteral(resourceName: "trash_battaries")
        default:
            self.icon.image = #imageLiteral(resourceName: "trash_other")
        }
        self.name.text = forCan.type
        self.location.text = forCan.address
        self.size.text = forCan.size
    }
    
    func colorsSetup() {
        name.textColor = UIColor.Font.White
        location.textColor = UIColor.Font.Gray
        size.textColor = UIColor.Font.White
        viewContainer.layer.cornerRadius = CGFloat.Design.CornerRadius
        viewContainer.backgroundColor = UIColor.Backgrounds.GrayLight
        backgroundColor = UIColor.Backgrounds.GrayDark
    }
}
