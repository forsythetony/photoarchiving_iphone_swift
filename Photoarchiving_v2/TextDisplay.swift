//
//  Labels.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    static func customLabel( backgroundColor : UIColor , textColor : UIColor , text : String , fontSize : CGFloat) -> UILabel {
        
        let newLabel = UILabel()
        
        newLabel.text = text
        newLabel.textColor = textColor
        newLabel.backgroundColor = backgroundColor
        newLabel.font = UIFont(name: GlobalConfig.defaultFontFamily, size: fontSize)
        newLabel.numberOfLines = 0
        newLabel.sizeToFit()
        
        return newLabel
    }
    
    
    
    
}

extension UITextField {
    
    static func customTextField( backgroundColor : UIColor, textColor : UIColor, text : String , placeholder : String , fontSize : CGFloat) -> UITextField {
        
        let newField = UITextField()
        
        newField.backgroundColor = backgroundColor
        newField.textColor = textColor
        newField.text = text
        newField.placeholder = placeholder
        newField.font = UIFont(name: GlobalConfig.defaultFontFamily, size: fontSize)
        
        return newField
    }
}