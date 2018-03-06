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
    
    var trashCan: TrashCan?
    
    func configureCell(forCan: TrashCan) {
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
}
