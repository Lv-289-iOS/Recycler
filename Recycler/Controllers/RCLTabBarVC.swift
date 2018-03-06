//
//  RCLTabBarVC.swift
//  Recycler
//
//  Created by Artem Rieznikov on 06.03.18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit

class RCLTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.tabBar.tintColor = UIColor.TabBar.tint
        self.tabBar.barTintColor = UIColor.TabBar.barTint
    }

}
