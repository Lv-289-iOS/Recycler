//
//  Authentificator.swift
//  testApp
//
//  Created by Ganna Melnyk on 3/1/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol AuthServiceDelegate: class {
    func transitionToProfile()
}

protocol GetUserData: class {
    func getUserData()
}

class RCLAuthentificator {
    
    weak var delegate: AuthServiceDelegate?
    
    func createUser(userName: String, email: String, phone: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                let user = User(firstName: userName, lastName: "", email: email, password: password, phoneNumber: phone, role: "someone")
                FirestoreService.shared.add(for: user, in: .users)
                print("added \(user.email)")
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    func login(login: String, password: String) {
        Auth.auth().signIn(withEmail: login, password: password) { (user, error) in
            if error == nil {
                print("You have successfully logged in")
                self.delegate?.transitionToProfile()
            } else {
                print("Error \(error!.localizedDescription)")
            }
        }

    }
    
    func isAUserActive() -> Bool {
        if Auth.auth().currentUser != nil {
//            if let user = Auth.auth().currentUser {
//                print(user.email)
//            }
            return true
        } else {
            return false
        }
    }
    
    static func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    static func email() -> String {
        if let user = Auth.auth().currentUser {
            return user.email!
        } else {
            return ""
        }
    }
   
}
