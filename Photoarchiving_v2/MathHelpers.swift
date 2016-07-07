//
//  MathHelpers.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit

public class TFMath {
    
    public static func randomCGFloatBetweenTwoPoints( min : CGFloat, max : CGFloat ) -> CGFloat
    {
        let diff = max - min
        let randFloat = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        
        return (min + (randFloat * diff))
    }
    
}