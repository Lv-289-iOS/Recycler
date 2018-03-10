//
//  RCLAddTrashLocationVC.swift
//  Recycler
//
//  Created by Yurii Tsymbala on 09.03.18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import CoreLocation

class RCLAddTrashLocationVC: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var addLocationBtn: UIButton!
    
    @IBAction func addLocationBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
