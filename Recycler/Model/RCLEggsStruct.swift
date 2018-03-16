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
            return [ #imageLiteral(resourceName: "trash_metal"), #imageLiteral(resourceName: "trash_paper"), #imageLiteral(resourceName: "trash_glass"), #imageLiteral(resourceName: "trash_plastic"), #imageLiteral(resourceName: "trash_organic")].shuffled()
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
        numberOfImages = 5
        imageSize = CGSize(width: 40, height: 40)
    }
}
