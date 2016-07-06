//
//  Photos.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit

struct TFPhoto {
    
    var mainURL : String?
    var thumbURL : String?
    var id : String?
    var title : String?
    var dateTaken : NSDate?
    var dateConf : Float?
    var uploadedBy : String?
    var repoID : String?
    
    
}

extension TFPhoto {
    
    static func testPhoto() -> TFPhoto {
        let mainURL = "http://40.86.85.30/cs4380/content/images/arch-main-110.JPG"
        let thumbURL = "http://40.86.85.30/cs4380/content/images/thumb/arch-main-110-thumbnail.JPG"
        let title = ""
        let date_taken = NSDate()
        let dateConf = Float(0.6)
        let id = "31"
        let r_id = "1"
        let uploader_id = "1"
        
        return TFPhoto(mainURL: mainURL, thumbURL: thumbURL, id: id, title: title, dateTaken: date_taken, dateConf: dateConf, uploadedBy: uploader_id, repoID: r_id)
    }
}
