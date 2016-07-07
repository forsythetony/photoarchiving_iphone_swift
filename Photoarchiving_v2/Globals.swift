//
//  Globals.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit

public class GlobalConfig {
    
    static let defaultFontFamily = "Avenir"
}
public extension UIFont {
    
    public static func globalFontWithSize( sz : CGFloat ) -> UIFont {
        return UIFont(name: GlobalConfig.defaultFontFamily, size: sz)!
    }
}