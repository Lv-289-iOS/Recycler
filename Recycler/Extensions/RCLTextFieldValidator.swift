//
//  CustomTextField.swift
//  testApp
//
//  Created by Ganna Melnyk on 3/5/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import UIKit

extension UITextField {
    public enum TextType {
        case emailAddress
        case password
        case phone
        case generic
    }
    
    public var textType: TextType {
        get {
            if keyboardType == .emailAddress {
                return .emailAddress
            } else if isSecureTextEntry {
                return .password
            } else if keyboardType == .numberPad {
                return .phone
            }
            return .generic
        }
        set {
            autocorrectionType = .no
            autocapitalizationType = .none
            switch newValue {
            case .emailAddress:
                keyboardType = .emailAddress
                isSecureTextEntry = false
                placeholder = "Email Address"
                
            case .password:
                keyboardType = .asciiCapable
                isSecureTextEntry = true
                
            case .generic:
                isSecureTextEntry = false
                
            case .phone:
                isSecureTextEntry = false
                keyboardType = .numberPad
            }
        }
    }
    
    public var valid: Bool {
        get {
            switch textType {
            case .password:
                return text != nil ? text!.count >= 8 && text!.count <= 25 : false
            case .emailAddress:
                let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9]+\\.[A-Za-z]{2,}"
                let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
                return text != nil ? predicate.evaluate(with: text) : false
            case .phone:
                let phoneRegex = "\\+38\\(\\d{3}\\)\\d{3}\\-\\d{4}"
                let predicate = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
                return text != nil ? predicate.evaluate(with: text) : false
            default:
                return text != nil ? text!.count >= 4 && text!.count <= 20 : false
            }
        }
    }
}

extension UITextField {
    func styleTextField() {
        if valid {
            self.backgroundColor = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
        } else {
            self.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
    }
    
    func initialStyler() {
        self.backgroundColor = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.borderWidth = 1
        self.clearButtonMode = .always
        self.textAlignment = .center
    }
}
