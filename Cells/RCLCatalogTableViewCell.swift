//
//  RCLCatalogTableViewCell.swift
//  Recycler
//
//  Created by Yurii Tsymbala on 3/5/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit

class RCLCatalogTableViewCell: UITableViewCell {

    @IBOutlet weak var catalogImageView: UIImageView!
    
    @IBOutlet weak var catalogLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
