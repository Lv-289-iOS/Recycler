//
//  ViewController.swift
//  Recycler
//
//  Created by Ostin Ostwald on 2/27/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let user = User(firstName: "roman", lastName: "shveda", email: "test@mail.ru", password: "1111", phoneNumber: "+3809655555", role: "1")

//        FirestoreService.shared.create(for: user, in: .users)
        FirestoreService.shared.get(from: .users, returning: User.self) { (users) in
            self.users = users
        }
//        for user in users{
//            FirestoreService.shared.delete(user, in: .users)
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

