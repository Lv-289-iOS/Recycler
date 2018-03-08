//
//  RCLUser.swift
//  Recycler
//
//  Created by Roman Shveda on 3/2/18.
//  Copyright © 2018 softserve.univercity. All rights reserved.
//

import Foundation

protocol Identifiable {
    var id: String? {get set}
}

struct User: Codable, Identifiable {
    
    var id: String? = nil
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var phoneNumber: String
    var role: String
    
    init(firstName: String, lastName: String, email: String, password: String, phoneNumber: String, role: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.role = role
    }

    init() {
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.password = ""
        self.phoneNumber = ""
        self.role = ""
    }
    
    init?(dictionary: [String: Any]) {
        guard let firstName = dictionary["firstName"] as? String, let lastName = dictionary["lastName"] as? String,
        let email = dictionary["email"] as? String, let password = dictionary["password"] as? String,
        let phoneNumber = dictionary["phoneNumber"] as? String,
        let role = dictionary["role"] as? String else { return nil }
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.role = role
    }

}
