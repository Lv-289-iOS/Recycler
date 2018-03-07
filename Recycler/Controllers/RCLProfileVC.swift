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
    @IBOutlet weak var profileTitle: UILabel!
    @IBOutlet weak var trashesTitle: UILabel!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneTitle: UILabel!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var phone: UITextField!
    
    let nib = "RCLProfileCell"
    let cellId = "RCLProfileCell"
    var isInEditMode = false
    var user = User(firstName: "Ivan", lastName: "Ivanenko", email: "petya@gmail.com", password: "12345678", phoneNumber: "063-000-00-00", role: "boss")
    let currentCan = TrashCan(trashId: "1", userId: "1", address: "Adress: Lviv",type: "metal", size: "Size: M")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: nib, bundle: nil ), forCellReuseIdentifier: cellId)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    private func viewSetup() {
        profileTitle.textColor = UIColor.Font.White
        firstName.textColor = UIColor.Font.White
        lastName.textColor = UIColor.Font.White
        phoneTitle.textColor = UIColor.Font.Gray
        phone.textColor = UIColor.Font.Gray
        trashesTitle.textColor = UIColor.Font.White
        
        firstName.text = user.firstName
        lastName.text = user.lastName
        phone.text = user.phoneNumber
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        self.view.backgroundColor = UIColor.Backgrounds.GrayDark
        profileView.backgroundColor = UIColor.Backgrounds.GrayLight
        profileView.layer.cornerRadius = CGFloat.Design.CornerRadius
    }
    
    @IBAction func editProfile(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isInEditMode = sender.isSelected
        firstName.isUserInteractionEnabled = isInEditMode
        lastName.isUserInteractionEnabled = isInEditMode
        phone.isUserInteractionEnabled = isInEditMode
        
        if isInEditMode {
            firstName.becomeFirstResponder()
        } else {
            firstName.resignFirstResponder()
            saveNewData()
        }
    }
    
    private func saveNewData() {
        user.update(firstName: firstName.text!, lastName: lastName.text!, phoneNumber: phone.text!)
    }
}

extension RCLProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RCLProfileCell else {
            return UITableViewCell()
        }
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        cell.backgroundColor = UIColor.Backgrounds.GrayLight
        cell.selectionStyle = .none
        
        cell.configureCell(forCan: currentCan)
        return cell
    }
}
