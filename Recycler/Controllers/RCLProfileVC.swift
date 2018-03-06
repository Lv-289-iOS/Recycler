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
        profileView.layer.cornerRadius = CGFloat.Design.CornerRadius
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension RCLProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return user.numberOfTrashCans
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
