//
//  POIItem.swift
//  Recycler
//
//  Created by Yurii Tsymbala on 3/21/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import Foundation
import CoreLocation

class POIItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var name: String!
    
    init(position: CLLocationCoordinate2D, name: String) {
        self.position = position
        self.name = name
    }
}
