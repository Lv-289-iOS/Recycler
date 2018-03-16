//
//  EggsStruct.swift
//  Recycler
//
//  Created by David on 3/15/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import Foundation
import UIKit

struct MiniGameStruct {
    
    var numberOfImages: Int
    var imageSize = CGSize.init()
    
    var baseImages: [UIImage]  {
        get {
            return [ #imageLiteral(resourceName: "game1"), #imageLiteral(resourceName: "game2"), #imageLiteral(resourceName: "game3"), #imageLiteral(resourceName: "game4"), #imageLiteral(resourceName: "game5"), #imageLiteral(resourceName: "game6"), #imageLiteral(resourceName: "game7"), #imageLiteral(resourceName: "game8"), #imageLiteral(resourceName: "game9")].shuffled()
        }
    }
    func getImages() -> [UIImage] {
        let newArr = Array(baseImages[0..<numberOfImages])
        return  newArr
    }
    
    init(number: Int, size: CGSize) {
        numberOfImages = number
        imageSize = size
    }
    init() {
        numberOfImages = Int(arc4random_uniform(9)) + 1
        imageSize = CGSize(width: 60, height: 60)
    }
}
