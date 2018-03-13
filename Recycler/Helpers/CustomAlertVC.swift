//
//  CustomAlertVC.swift
//  
//
//  Created by Ganna Melnyk on 3/13/18.
//

import UIKit

class CustomAlertVC: UIViewController {

    @IBOutlet var errorTextLabel: UILabel!
    
    @IBAction func submitActionButton(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
