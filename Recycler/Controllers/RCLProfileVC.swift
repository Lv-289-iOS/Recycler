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
    
    let nib = "RCLProfileCell"
    let cellId = "RCLProfileCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: nib, bundle: nil ), forCellReuseIdentifier: cellId)
    }
    
    private func viewSetup() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        self.view.backgroundColor = UIColor.Backgrounds.ProfileVC
        profileView.backgroundColor = UIColor.Backgrounds.ProfileView
        profileView.layer.cornerRadius = CGFloat.Design.CornerRadius
    }
}

extension RCLProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RCLProfileCell else {
            return UITableViewCell()
        }
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        cell.backgroundColor = UIColor.Backgrounds.ProfileView
        
        let currentCan = TrashCan(id: "1", trashId: "1", userId: "1", address: "adressadressadressadressadressadress", isFull: true, type: "metal", size: "S")
        cell.configureCell(forCan: currentCan)
        return cell
    }
}
