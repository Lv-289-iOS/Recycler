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
        switch forCan. {
        case . :
            <#code#>
        default:
            <#code#>
        }
    }
    
}
