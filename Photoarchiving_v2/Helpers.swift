//
//  Helpers.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit

public enum TFDateFormatType : String {
    case ISO = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    case v1 = "yyyy-MM-dd"
    case api = "yyyy-MM-dd HH:mm:ss"
}

public class TFDateHelper {
    
    static let sharedInstance = TFDateHelper()
    private let calendar : NSCalendar = NSCalendar.currentCalendar()
    private let dateFormatter : NSDateFormatter = NSDateFormatter()
    private let lowerReferenceDate : NSDate = NSDate.ReferenceDate()
    
    
    public func getYearsArrayFromDateRange( dr : TFDateRange ) -> [Int] {
        
        let startYear = self.getYearFromDate(dr.startDate)
        let endYear = self.getYearFromDate(dr.endDate)
        
        var years = [Int]()
        
        for i in startYear...endYear {
            
            years.append(i)
        }
        
        return years
    }
    
    public func getYearFromDate( date : NSDate ) -> Int {
        
        let componentUnit = NSCalendarUnit.Year
        
        return self.calendar.component(componentUnit, fromDate: date)
    }
    
    public func getDateFromString( dateString : String , dateType : TFDateFormatType) -> NSDate? {
        
        self.dateFormatter.dateFormat = dateType.rawValue
        
        return self.dateFormatter.dateFromString(dateString)
    }
    
    public func getV1StringFromDate(date : NSDate) -> String {
        
        self.dateFormatter.dateFormat = TFDateFormatType.v1.rawValue
        
        return self.dateFormatter.stringFromDate(date)
        
    }
    public func convertDateToTFDate( date : NSDate) -> TFDate {
        
        var newDate = TFDate(date: date)
        
        newDate.V1String = self.getV1StringFromDate(date)
        newDate.referenceInt = Int(date.timeIntervalSinceDate(self.lowerReferenceDate))
        
        let dateComponentUnits : NSCalendarUnit = [ NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
        let dateComponents = self.calendar.components(dateComponentUnits, fromDate: date)
        
        newDate.year = dateComponents.year
        newDate.month = dateComponents.month
        newDate.day = dateComponents.day
        
        
        return newDate
    }
    
    public func getLogStringForTFDate( date : TFDate) -> String {
        
        let logString = TFLogString()
        
        logString.addLogValue("V1 String", v: (date.V1String != nil ? date.V1String! : "nil"))
        logString.addLogValue("Reference Int", v: (date.referenceInt != nil ? "\(date.referenceInt)" : "nil"))
        logString.addLogValue("Year", v: (date.year != nil ? "\(date.year)" : "nil"))
        logString.addLogValue("Month", v: (date.month != nil ? "\(date.month)" : "nil"))
        logString.addLogValue("Day", v: (date.day != nil ? "\(date.day)" : "nil"))
        
        let logStringRaw = logString.getLogString()
        
        return logStringRaw
    }
    
    
    
    //  Factory Functions
    
    public func getYearRange( start : NSDate , end : NSDate ) -> TFDateRange? {
        
        let startSeconds = start.timeIntervalSinceDate(self.lowerReferenceDate)
        let endSeconds = end.timeIntervalSinceDate(self.lowerReferenceDate)
        
        if( endSeconds > startSeconds ) {
            
            var dr = TFDateRange(s: start, e: end)
            
            dr.secondsDiff = Int(abs(endSeconds - startSeconds))
            
            let endYear = self.getYearFromDate(end)
            let startYear = self.getYearFromDate(start)
            
            dr.yearsDiff = Int(endYear - startYear)
            
            return dr
        }
        else {
            return nil
        }
        
        
        
    }
    
    
    public func defaultMinDate() -> NSDate
    {
        return self.getDateFromString("1900-01-01", dateType: .v1)!
    }
    
    public func defaultMaxDate() -> NSDate
    {
        return NSDate()
    }
}

//  For Timeline
public extension TFDateHelper
{
    public func getPosValue( dr : TFDateRange, lineLength : CGFloat, pointDate : NSDate) -> CGFloat
    {
        //  Get seconds from start
        let secondsFromStart = pointDate.timeIntervalSinceDate(dr.startDate)
        
        let conversionFactor = Float(lineLength) / Float(dr.secondsDiff!)
        
        let newX = CGFloat( conversionFactor * Float(secondsFromStart))
        
        return newX
    }
}
public struct TFDateRange {
    
    public let startDate : NSDate
    public let endDate : NSDate

    public var yearsDiff : Int?
    public var secondsDiff : Int?
    
    init(s : NSDate , e : NSDate) {
        self.startDate = s
        self.endDate = e
    }
    
}
public struct TFDate {
    
    public var date : NSDate?
    public var V1String : String?
    public var referenceInt : Int?
    public var year : Int?
    public var month : Int?
    public var day : Int?
    
    init( date : NSDate) {
        self.date = date
    }
}

extension NSDate {
    
    class func ReferenceDate() -> NSDate {
        return NSDate.distantPast()
    }
}


public class TFLogString {
    
    private var logValues = [String : String]()
    
    
    public func addLogValue( k : String , v : String ) {
        self.logValues[k] = v
    }
    
    
    public func getLogString() -> String {
        
        var logString : String = ""
        
        logString += "\n"
        
        for (title , value) in self.logValues {
            
            logString += "\n\(title) :\t\(value)\n"
            
        }
        
        logString += "\n"
        
        return logString
    }
    
}