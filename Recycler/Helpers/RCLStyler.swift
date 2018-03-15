//
//  Styler.swift
//  testApp
//
//  Created by Ganna Melnyk on 3/1/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import Foundation
import UIKit

class RCLStyler {
    
    func styleButton(button: UIButton) {
        button.backgroundColor = UIColor.Backgrounds.GrayLight
        button.tintColor = UIColor.Button.titleColor
        button.layer.cornerRadius = CGFloat.Design.CornerRadius
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 1
    }
    
    func renderImage(view: UIImageView, image: UIImage) {
        view.image = image
        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        view.tintColor = UIColor.Font.White
    }
    
}
extension UIViewController {
    
    func addTitleLabel(text: String){
        let label = UILabel(frame: CGRect(x: 16, y: 21, width: 300, height: 32))
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.text = text
        label.textColor = UIColor.white
        self.view.addSubview(label)
    }
}

