//
//  InfoWindow.swift
//  testApp
//
//  Created by Ganna Melnyk on 3/1/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import Foundation
import UIKit

class RCLInfoWindow {

    var alertController: UIAlertController?
    var wrongCredentialsTitle = "Wrong credentials"
    var wrongCredentialsText = "please, check login and password"
    var okAction = "ok"
    
    func wrongCredentials() -> UIAlertController {
        alertController = UIAlertController(title: wrongCredentialsTitle, message: wrongCredentialsText, preferredStyle: .alert)
        let action = UIAlertAction(title: okAction, style: .default, handler: nil)
        //workaround because alertController has many subviews
        alertController?.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
        alertController?.view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        alertController?.addAction(action)
        return alertController!
    }
    
//    func showAlertAction(text: String, controller: UIViewController) {
//        let alertController = UIAlertController(title: "Oops!", message: text, preferredStyle: .alert)
//        alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.Backgrounds.GrayLight
//        alertController.view.tintColor = UIColor.Font.White
//        text.addAtt
//        
//        let fontAwesomeAttributes = [NSAttributedStringKey.foregroundColor : UIColor.red]
//        
//        
//        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        controller.present(alertController, animated: true, completion: nil)
//        alertController.view.tintColor = UIColor.green
//        
//    }
    
    
//    let fontAwesomeAttributes = [
//        NSForegroundColorAttributeName : UIColor.redColor()
//    ]
//    let matchRange = customTitle.rangeOfString(fontAwesomeHeart)
//    attributedString.addAttributes(fontAwesomeAttributes, range: matchRange)
//    alertController.setValue(attributedString, forKey: "attributedTitle")
}
