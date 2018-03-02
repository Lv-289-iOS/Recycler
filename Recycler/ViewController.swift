//
//  ViewController.swift
//  Recycler
//
//  Created by Ostin Ostwald on 2/27/18.
//  Copyright © 2018 softserve.univercity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FirestoreService.shared.read()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

