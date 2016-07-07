//
//  ViewController.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let dateHelper = TFDateHelper.sharedInstance
        
        let oldDate = dateHelper.getDateFromString("1903-11-02", dateType: .v1)
        
        let tfDate = dateHelper.convertDateToTFDate(oldDate!)
        
        let tfDateLogString = dateHelper.getLogStringForTFDate(tfDate)
        
        //print(tfDateLogString)
        
        let newDate = NSDate()
        
        let dateRange = dateHelper.getYearRange(oldDate!, end: newDate)
    
        let contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 2.0)
        
        
        let timelineSVFrame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + 20.0, self.view.bounds.width, self.view.bounds.height - 20.0)
        
        let timelineSV = TFTimelineScrollView(frame: timelineSVFrame, contentSize: contentSize, dateRange: dateRange!)
        timelineSV.backgroundColor = Color.patternedTweed()
        
        self.view.addSubview(timelineSV)
    
    
//        let defaultPhotoData = TFPhoto.testPhoto()
//        
//        let photoView = TFPhotoThumbView(photoData: defaultPhotoData)
//        
//        
//        timelineSV.addSubview(photoView)
//        photoView.customAddConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

