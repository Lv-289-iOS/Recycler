//
//  CellFunctionality.swift
//  Recycler
//
//  Created by Roman Shveda on 3/22/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import Foundation

class CellFunctionality {
    func configureCell(forData: (Trash,TrashCan,User)) {
//        colorsSetup()
//        self.data = forData
        
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
//        self.userName.text = "\(data.2.firstName) \(data.2.lastName)"
//        self.location.text = data.1.address
//        self.size.text = sizeName
//        self.phone.text = data.2.phoneNumber
        
    }
}
