//
//  CustomAlertVC.swift
//  
//
//  Created by Ganna Melnyk on 3/13/18.
//

import UIKit

class RCLCustomAlertVC: UIViewController {

    @IBOutlet var errorTextLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var submitButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorTextLabel.backgroundColor = UIColor.Backgrounds.GrayLight
        submitButtonOutlet.backgroundColor = UIColor.Backgrounds.GrayLight
        mainView.backgroundColor = UIColor.Backgrounds.GrayDark
//        mainView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        mainView.layer.borderWidth = 2
        mainView.layer.cornerRadius = CGFloat.Design.CornerRadius * 3
        submitButtonOutlet.layer.cornerRadius = CGFloat.Design.CornerRadius
        errorTextLabel.layer.cornerRadius = CGFloat.Design.CornerRadius
    }
    
    @IBAction func submitActionButton(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
