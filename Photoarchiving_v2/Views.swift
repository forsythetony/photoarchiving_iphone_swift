//
//  Views.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func pinWidth( width : CGFloat ) {
        
        let widthAutoLayoutConstraint = NSLayoutConstraint( item: self,
                                                            attribute: .Width,
                                                            relatedBy: .Equal,
                                                            toItem: nil,
                                                            attribute: .NotAnAttribute,
                                                            multiplier: 1,
                                                            constant: width)
        self.addConstraint(widthAutoLayoutConstraint)
    }
    
    func pinHeight( height : CGFloat ) {
        let heightConstraint = NSLayoutConstraint( item: self,
                                                            attribute: .Height,
                                                            relatedBy: .Equal,
                                                            toItem: nil,
                                                            attribute: .NotAnAttribute,
                                                            multiplier: 1,
                                                            constant: height)
        self.addConstraint(heightConstraint)
    }
    
    
    func pinLeftToLeft( v : UIView, spacing : CGFloat, relatedBy : NSLayoutRelation) {
        
        let constraint = NSLayoutConstraint( item : self,
                                             attribute: .Leading,
                                             relatedBy: relatedBy,
                                             toItem: v,
                                             attribute: .Leading,
                                             multiplier: 1,
                                             constant: spacing)
        
        self.addConstraint(constraint)
    }
    
    func pinLeftToRight( v : UIView, spacing : CGFloat, relatedBy : NSLayoutRelation) {
        
        let constraint = NSLayoutConstraint( item : self,
                                             attribute: .Leading,
                                             relatedBy: relatedBy,
                                             toItem: v,
                                             attribute: .Trailing,
                                             multiplier: 1,
                                             constant: spacing)
        
        self.addConstraint(constraint)
    }
    
    func pinRightToRight( v : UIView, spacing : CGFloat, relatedBy : NSLayoutRelation) {
        
        let constraint = NSLayoutConstraint( item : self,
                                             attribute: .Trailing,
                                             relatedBy: relatedBy,
                                             toItem: v,
                                             attribute: .Trailing,
                                             multiplier: 1,
                                             constant: spacing)
        
        self.addConstraint(constraint)
    }
    
    func pinRightToLeft( v : UIView, spacing : CGFloat, relatedBy : NSLayoutRelation) {
        let constraint = NSLayoutConstraint( item : self,
                                             attribute: .Trailing,
                                             relatedBy: relatedBy,
                                             toItem: v,
                                             attribute: .Leading,
                                             multiplier: 1,
                                             constant: spacing)
        
        self.addConstraint(constraint)
    }
    
    func pinCenterY( v : UIView, spacing : CGFloat, relatedBy : NSLayoutRelation) {
        let constraint = NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: relatedBy, toItem: v, attribute: .CenterY, multiplier: 1.0, constant: spacing)
        
        self.addConstraint(constraint)
    }
    
    func pinCenterX( v : UIView, spacing : CGFloat, relatedBy : NSLayoutRelation) {
        let constraint = NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: relatedBy, toItem: v, attribute: .CenterX, multiplier: 1.0, constant: spacing)
        
        self.addConstraint(constraint)
    }
}