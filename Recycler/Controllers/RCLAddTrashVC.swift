//
//  RCLAddTrashVC.swift
//  Recycler
//
//  Created by Yurii Tsymbala on 09.03.18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit

class RCLAddTrashVC: UIViewController {
    
    private let sizeOfTrash = ["Small", "Medium", "Large"]
    
    var trashLabelFromCatalogVC = ""
    
    var trashImageFromCatalogVC :UIImage?
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var trashTableView: UITableView!
    
    @IBOutlet weak var typeOfTrashImage: UIImageView!
    
    @IBOutlet weak var typeOfTrashLabel: UILabel!
    
    @IBAction func orderTrashBtn(_ sender: UIButton) {
    }
    
    @IBAction func dismissPopUp(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        trashTableView.delegate = self
        trashTableView.dataSource = self
        typeOfTrashLabel.text = trashLabelFromCatalogVC
        typeOfTrashImage.image = trashImageFromCatalogVC
        super.viewDidLoad()
    }
}

extension RCLAddTrashVC: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sizeOfTrash.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = sizeOfTrash[row]
        return NSAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
}

extension RCLAddTrashVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sizeOfTrash[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}


extension RCLAddTrashVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = trashTableView.dequeueReusableCell(withIdentifier: "SizeTrashCell") as! RCLSizeViewCell
            return cell
        case 1:
            let cell = trashTableView.dequeueReusableCell(withIdentifier: "LocationTrashCell") as! RCLLocationViewCell
            return cell
        default:
            fatalError("you missed some cells")
        }
    }
}

extension RCLAddTrashVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            performSegue(withIdentifier: "AddTrashLocationSegue", sender: self)
        default:
            return
        }
    }
}
