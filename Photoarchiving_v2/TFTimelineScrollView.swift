//
//  TFTimelineScrollView.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit

enum TFTimelineScrollViewYearFormat : Int{
    case None = 0
    case Ten
    case Five
    case One
}

public struct TFTimelineScrollViewPoint {
    
    public var point : CGPoint
    public var titleString : String
    public var shouldDisplayTitle : Bool = false
}
public class TFTimelineScrollView : UIScrollView {
    
    public var dateRange : TFDateRange
    private let dateMan = TFDateHelper.sharedInstance
    
    public var lineColor : UIColor = Color.whiteColor()
    public var textColor : UIColor = Color.whiteColor()
    
    private var yearPoints : [CGPoint] = [CGPoint]()
    private var yearPointsClean : [TFTimelineScrollViewPoint] = [TFTimelineScrollViewPoint]()
    
    public var verticalPadding : CGFloat = 20.0
    public var horizontalPadding : CGFloat = 20.0
    
    public var longLineLength : CGFloat = 30.0
    public var shortLineLength : CGFloat = 20.0
    
    public var paddingBetweenLinesAndText : CGFloat = 5.0
    
    private var photoThumbViews = [TFPhotoThumbView]()
    
    public var lineWidth : CGFloat = 1.0 {
        didSet {
            if (lineWidth < 0.0)
            {
                lineWidth = 0.0
            }
            else if (lineWidth > 10.0)
            {
                lineWidth = 10.0
            }
        }
    }
    
    
    
    
    
    
    init( frame : CGRect, contentSize : CGSize , dateRange : TFDateRange) {
        
        self.dateRange = dateRange
        
        
        super.init(frame: frame)
        
        self.contentSize = contentSize
        
        self.buildYearPoints()

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func drawRect(rect: CGRect) {
        
        let ctx : CGContextRef = UIGraphicsGetCurrentContext()!
        
        CGContextSaveGState(ctx)
        
        
        drawMainTimelineLine()
        addYearPoints()

        CGContextRestoreGState(ctx)
    }
    
    public func addPhotoInfo( photoInfo : TFPhoto)
    {
        //  Calculate center
        let centerX = TFMath.randomCGFloatBetweenTwoPoints(self.horizontalPadding + self.longLineLength + (50.0), max: self.bounds.width)
        let centerY = self.dateMan.getPosValue(self.dateRange, lineLength: (self.contentSize.height - (self.verticalPadding * 2.0)), pointDate: photoInfo.dateTaken!) + self.verticalPadding
        
        let photoCenter = CGPoint(x: centerX, y: centerY)
        
        //  Create photo view
        let photoView = TFPhotoThumbView(photoData: photoInfo)
        
        self.addSubview(photoView)
        photoView.center = photoCenter
        
        self.photoThumbViews.append(photoView)
        
    }
    private func addYearPoints() {
        
        for yearPoint in self.yearPointsClean {

            if(yearPoint.shouldDisplayTitle) {
                
                addHorizontalLineAtPoint(yearPoint.point, len: longLineLength)
                
                let lbl = createYearLabel(yearPoint.titleString)
                
                var lblRect = lbl.frame
                lblRect.origin.y = yearPoint.point.y;
                
                lblRect.origin.x = yearPoint.point.x + longLineLength + self.paddingBetweenLinesAndText
                
                
                lbl.frame = lblRect
                
                lbl.center = CGPoint(x: lbl.center.x, y: yearPoint.point.y)
                
                
                self.addSubview(lbl)
            }
            else {
                addHorizontalLineAtPoint(yearPoint.point, len: shortLineLength)
            }
        }
        
    }
    private func createYearLabel( str : String ) -> UILabel {
        
        let newLabel = UILabel()
        
        newLabel.text = str
        newLabel.textColor = self.textColor
        newLabel.font = UIFont(name: GlobalConfig.defaultFontFamily, size: 10.0)
        newLabel.sizeToFit()
        
        return newLabel
    }
    
    
    
    private func addHorizontalLineAtPoint( pnt : CGPoint, len : CGFloat) {
        
        let startPoint = pnt
        let endPoint = CGPoint(x: pnt.x + len, y: pnt.y)
        
        let path = UIBezierPath()
        path.moveToPoint(startPoint)
        path.addLineToPoint(endPoint)
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = self.lineColor.CGColor
        shapeLayer.lineWidth = self.lineWidth
        
        self.layer.addSublayer(shapeLayer)
        
    }
    private func buildYearPoints() {
        
        
        let yearsArr = self.dateMan.getYearsArrayFromDateRange(self.dateRange)
        
        let yearsCount = yearsArr.count
        
        let contentHeight = self.contentSize.height - (verticalPadding * 2.0)
        
        let heightPerYear = contentHeight / CGFloat(yearsCount - 1)
        
        var yearsFormat = TFTimelineScrollViewYearFormat.None
        
        if (heightPerYear > 50.0) {
            yearsFormat = TFTimelineScrollViewYearFormat.One
        }
        else if (heightPerYear > 5.0) {
            yearsFormat = TFTimelineScrollViewYearFormat.Five
        }
        
        var startY = verticalPadding
        
        for i in 0...(yearsCount - 1) {
            
            var pnt : CGPoint
            var title : String
            var shouldDisplay : Bool = false
            
            let yearVal = yearsArr[i]
            
            title = "\(yearVal)"
            
            pnt = CGPointMake(horizontalPadding, startY)
            
            if( i == 0 || i == (yearsCount - 1)) {
                shouldDisplay = true
            }
            else {
                switch yearsFormat {
                case .One:
                    shouldDisplay = true
                    
                case .Five:
                    if (yearVal % 5 == 0) {
                        shouldDisplay = true
                    }
                    
                case .Ten:
                    if(yearVal % 10 == 0) {
                        shouldDisplay = true
                    }
                default:
                    shouldDisplay = false
                }
            }
            
            print("\nYear :\t\(yearVal)\nShould Display :\t\(shouldDisplay)\n")
            
            let tfPoint = TFTimelineScrollViewPoint(point: pnt, titleString: title, shouldDisplayTitle: shouldDisplay)
            
            self.yearPointsClean.append(tfPoint)
            
            startY += heightPerYear
            
        }
    }
    private func drawMainTimelineLine() {
        
        
        let linePadding = verticalPadding
        
        
        let lineLength = CGFloat(self.contentSize.height - (20.0 * 2))
        
        
        let startPoint = CGPoint(x: horizontalPadding, y: linePadding)
        let endPoint = CGPoint(x: horizontalPadding , y: linePadding + lineLength)
        
        let path = UIBezierPath()
        
        path.moveToPoint(startPoint)
        path.addLineToPoint(endPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = self.lineColor.CGColor
        shapeLayer.lineWidth = self.lineWidth
        
        self.layer.addSublayer(shapeLayer)
        
        
    }
}
