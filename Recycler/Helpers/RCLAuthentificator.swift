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
    func transitionToCust()
    func transitionToEmpl()
    
}

class RCLAuthentificator {
    
    weak var delegate: AuthServiceDelegate?
    
    func createUser(userName: String, userLastName: String, email: String, phone: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                let user = User(firstName: userName, lastName: userLastName, email: email, password: password, phoneNumber: phone, role: .cust)
                FirestoreService.shared.add(for: user, in: .users)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    func login(login: String, password: String) {
        Auth.auth().signIn(withEmail: login, password: password) { (user, error) in
            if error == nil {
                FirestoreService.shared.getUserBy(email: login, completion: { (user) in
                    if let tempUser = user {
                        if tempUser.role == RCLUserRole.empl.rawValue {
                            self.delegate?.transitionToEmpl()
                        } else {
                            self.delegate?.transitionToCust()
                        }
                    }
                })
                
            } else {
                print("Error \(error!.localizedDescription)")
            }
        }

    }
    
    func isAUserActive() {
        if Auth.auth().currentUser != nil {
            FirestoreService.shared.getUserBy(email: (Auth.auth().currentUser?.email)!, completion: { (user) in
                if let tempUser = user {
                    if tempUser.role == RCLUserRole.empl.rawValue {
                        self.delegate?.transitionToEmpl()
                    } else {
                        self.delegate?.transitionToCust()
                    }
                }
            })
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
