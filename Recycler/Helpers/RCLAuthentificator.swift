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
    func alert(text: String)
}

class RCLAuthentificator {
    weak var delegate: AuthServiceDelegate?
    
    private init() { }
    static let shared = RCLAuthentificator()
    
    func createUser(userName: String, userLastName: String, email: String, phone: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] (user, error) in
            if error == nil {
                let user = User(firstName: userName, lastName: userLastName, email: email, password: password, phoneNumber: phone, role: .cust)
                FirestoreService.shared.add(for: user, in: .users)
                guard let weakSelf = self else {
                    return
                }
                weakSelf.delegate?.transitionToCust()
            } else {
                self?.delegate?.alert(text: (error?.localizedDescription)!)
            }
        }
    }
    
    func login(login: String, password: String) {
        Auth.auth().signIn(withEmail: login, password: password) {[weak self] (user, error) in
            if error == nil {
                FirestoreService.shared.getUserBy(email: login, completion: { (user) in
                    if let tempUser = user {
                        guard let weakSelf = self else {
                            return
                        }
                        if tempUser.role == RCLUserRole.empl.rawValue {
                            weakSelf.delegate?.transitionToEmpl()
                        } else {
                            weakSelf.delegate?.transitionToCust()
                        }
                    }
                })
            } else {
                self?.delegate?.alert(text: "wrong credentials")
            }
        }
    }
    
    func isAUserActive() {
        if Auth.auth().currentUser != nil {
            FirestoreService.shared.getUserBy(email: (Auth.auth().currentUser?.email)!, completion: {[weak self] (user) in
                if let tempUser = user {
                    guard let weakSelf = self else {
                        return
                    }
                    if tempUser.role == RCLUserRole.empl.rawValue {
                        weakSelf.delegate?.transitionToEmpl()
                    } else {
                        weakSelf.delegate?.transitionToCust()
                    }
                }
            })
        }
    }
    
    class func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    class func email() -> String {
        if let user = Auth.auth().currentUser {
            if let userEmail = user.email {
                return userEmail
            }
            return ""
        } else {
            return ""
        }
    }
}
