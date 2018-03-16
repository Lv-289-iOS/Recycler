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
    static var darkModeratePink: UIColor { return UIColor(red:0.60, green:0.20, blue:0.40, alpha:1.0) }
    
    struct Backgrounds {
        static var GrayLighter: UIColor  { return UIColor(red:0.26, green:0.30, blue:0.33, alpha:1.0) }
        static var GrayLight: UIColor  { return UIColor(red:0.15, green:0.17, blue:0.18, alpha:1.0) }
        static var GrayDark: UIColor  { return UIColor(red:0.08, green:0.09, blue:0.11, alpha:1.0) }
         static var GrayDarkAlpha: UIColor  { return UIColor(red:0.08, green:0.09, blue:0.11, alpha:0.7) }
    }
    struct Font {
        static var White: UIColor { return UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0) }
        static var Gray: UIColor { return UIColor(red:0.39, green:0.40, blue:0.41, alpha:1.0) }
    }
    struct TabBar {
        static var tint: UIColor { return darkModeratePink }
        static var barTint: UIColor { return black }
    }
    struct Button {
        static var backgroundColor: UIColor { return darkModeratePink }
        static var titleColor: UIColor { return white }
    }
    
    struct TextFieldBackGrounds {
        static var BackgroundForFalse: UIColor { return UIColor(red:0.75, green:0.10, blue:0.10, alpha:1.0) }
    }
    struct Charts {
        static var color0: UIColor  { return UIColor(red:0.633, green:0.786, blue:0.333, alpha:1.0) }
        static var color1: UIColor  { return UIColor(red:0.310, green:0.680, blue:0.545, alpha:1.0) }
        static var color2: UIColor  { return UIColor(red:0.864, green:0.351, blue:0.600, alpha:1.0) }
        static var color3: UIColor  { return UIColor(red:0.526, green:0.265, blue:0.576, alpha:1.0) }
        static var color4: UIColor  { return UIColor(red:0.286, green:0.640, blue:0.792, alpha:1.0) }
        static var color5: UIColor  { return UIColor(red:0.316, green:0.369, blue:0.651, alpha:1.0) }
        static var color6: UIColor  { return UIColor(red:0.886, green:0.462, blue:0.227, alpha:1.0) }
        static var color7: UIColor  { return UIColor(red:0.766, green:0.196, blue:0.369, alpha:1.0) }
    }
}
