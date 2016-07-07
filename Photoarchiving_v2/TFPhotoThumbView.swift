//
//  TFPhotoThumbView.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit



public class TFPhotoThumbView : UIView {
    
    let photoData : TFPhoto
    private let viewDim : CGFloat = 75.0
    
    public var imgView : UIImageView?
    
    override init(frame: CGRect) {
        
        self.photoData = TFPhoto()
        
        super.init(frame: frame)
        
        
    }
    
    init(photoData : TFPhoto) {
        
        let viewSize = CGSizeMake(viewDim, viewDim)
        
        var viewFrame = CGRectZero
        
        viewFrame.size = viewSize

        self.photoData = photoData
        

        super.init(frame: viewFrame)
        
        self.imgView = makeImageView()
        
        self.addSubview(self.imgView!)
        self.imgView?.center = self.center
        self.backgroundColor = Color.whiteColor()
        downloadImage(NSURL(string: photoData.thumbURL!)!)
        
    }
    
    func getDataFromURL( url : NSURL, completion: ((data : NSData?, response : NSURLResponse?, error : NSError?) -> Void)) {
        
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
        }.resume()
        
    }
    
    func downloadImage(url: NSURL) {
        
        getDataFromURL(url) { (data, response, error) in
            guard let data = data where error == nil else { return }
            dispatch_async(dispatch_get_main_queue(), { 
                self.imgView?.image = UIImage(data: data)
            })
        }
    }
    public func customAddConstraints() {
        
        if let imgViewPos = self.imgView {
            
            imgViewPos.addConstraints([
                NSLayoutConstraint(item: imgViewPos, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: viewDim),
                NSLayoutConstraint(item: imgViewPos, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: viewDim),
                NSLayoutConstraint(item: imgViewPos, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: imgViewPos, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
                
                ]);
        }
        
        
        
    }
    private func makeImageView() -> UIImageView{
    
        let imageView = UIImageView()
        
        imageView.frame = CGRectMake(0.0, 0.0, viewDim, viewDim)
        
        
        return imageView
    
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "didTouchPhoto", object: self, userInfo: ["photoInfo" : self.photoData]))
        
    }
}





