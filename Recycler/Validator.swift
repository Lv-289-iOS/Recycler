//
//  Validator.swift
//  testApp
//
//  Created by Ganna Melnyk on 3/5/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import Foundation

class Validator {
    
    func nameValidator(name: String) -> Bool {
        return name.count >= 2 && name.count < 20
    }
    
    func passwordValidator(pass: String) -> Bool {
        return pass.count >= 8 && pass.count < 25
    }
    
    func passMatching(pass: String, repeatedPass: String) -> Bool {
        return pass == repeatedPass
    }
    
    func emailValidator(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
    
    func phoneValidator(phone: String) -> Bool {
        let phoneRegex = "\\+38\\(\\d{3}\\)\\d{3}\\-\\d{4}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: phone)
    }
    
}
