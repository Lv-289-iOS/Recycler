//
//  ViewController.swift
//  Recycler
//
//  Created by Ostin Ostwald on 2/27/18.
//  Copyright © 2018 softserve.univercity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let user = User(firstName: "Roman", lastName: "Shveda")
        
//        FirestoreService.shared.create(for: user, in: .users)
        FirestoreService.shared.read(from: .users, returning: User.self) { (users) in
            self.users = users
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

