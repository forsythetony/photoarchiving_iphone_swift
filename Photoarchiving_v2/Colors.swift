//
//  Colors.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit

public typealias Color = UIColor

public extension Color {
    
    convenience init(hex: String) {
        var rgbInt: UInt64 = 0
        let newHex = hex.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: newHex)
        scanner.scanHexLongLong(&rgbInt)
        let r: CGFloat = CGFloat((rgbInt & 0xFF0000) >> 16)/255.0
        let g: CGFloat = CGFloat((rgbInt & 0x00FF00) >> 8)/255.0
        let b: CGFloat = CGFloat(rgbInt & 0x0000FF)/255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    convenience init(rgba: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)) {
        self.init(red: rgba.r, green: rgba.g, blue: rgba.b, alpha: rgba.a)
    }
    
    static func patternedTweed() -> Color {
        return UIColor(patternImage: UIImage(named: "tweed.png")!)
    }
}
