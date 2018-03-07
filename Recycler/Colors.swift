//
//  Colors.swift
//  Recycler
//
//  Created by David on 3/6/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    struct Backgrounds {
        static var GrayLight: UIColor  { return UIColor(red:0.15, green:0.17, blue:0.18, alpha:1.0) }
        static var GrayDark: UIColor  { return UIColor(red:0.08, green:0.09, blue:0.11, alpha:1.0) }
    }
    struct Font {
        static var White: UIColor { return UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0) }
        static var Gray: UIColor { return UIColor(red:0.39, green:0.40, blue:0.41, alpha:1.0) }
    }
    struct TabBar {
        static var tint: UIColor { return UIColor(red:0.60, green:0.20, blue:0.40, alpha:1.0) }
        static var barTint: UIColor { return UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0) }
    }
}
