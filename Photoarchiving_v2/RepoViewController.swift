//
//  RepoViewController.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {

    var repoInfo : TFRepository?
    
    private let dataMan = TFDataManager.sharedInstance
    private var timelineScrollView : TFTimelineScrollView?
    private var photoViews : [TFPhotoThumbView] = [TFPhotoThumbView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getPhotos()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTimeline()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func getPhotos() {
        
        self.dataMan.getPhotosForRepository((repoInfo?.repo_id!)!) { (result, error) in
            
            if error == nil
            {
                self.repoInfo?.photos = result!
                print(self.repoInfo?.photos)
                
                dispatch_async(dispatch_get_main_queue(), { 
                    self.addPhotosToTimeline()
                })
            }
        }
        
    }
    
    private func addPhotosToTimeline() {
        
        for photoInfo in (self.repoInfo?.photos)!
        {
            self.timelineScrollView?.addPhotoInfo(photoInfo)
        }
        
    }
    private func setupTimeline() {
        
        let range = TFDateHelper.sharedInstance.getYearRange((self.repoInfo?.minDate)!, end: self.repoInfo!.maxDate!)
        
        let contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.height * 2.0)
        
        let frame = self.view.bounds
        
        self.timelineScrollView = TFTimelineScrollView(frame: frame, contentSize: contentSize, dateRange: range!)
        
        self.view.addSubview(self.timelineScrollView!)
        
    }
}
