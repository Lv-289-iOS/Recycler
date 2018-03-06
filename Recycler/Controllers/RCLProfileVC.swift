//
//  RCLProfileVC.swift
//  Recycler
//
//  Created by Artem Rieznikov on 02.03.18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit

class RCLProfileVC: UIViewController {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileView.backgroundColor = UIColor.Backgrounds.ProfileView
        
    }
}
