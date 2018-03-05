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

struct User: Codable,Identifiable{
    
    var id: String? = nil
    var firstName: String
    var lastName: String
//    var email: String
//    var password: String
//    var phoneNumber: String
//    var role: Int
    
//    init(firstName: String, lastName: String, email: String, password: String, phoneNumber: String, role: Int) {
//        self.firstName = firstName
//        self.lastName = lastName
//        self.email = email
//        self.password = password
//        self.phoneNumber = phoneNumber
//        self.role = role
//    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
}
