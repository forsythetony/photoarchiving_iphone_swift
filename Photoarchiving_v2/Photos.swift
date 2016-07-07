//
//  Photos.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit

public struct TFRepository {
    var repo_id : String?
    var title : String?
    var dateCreated : NSDate?
    var description : String?
    var minDate : NSDate?
    var maxDate : NSDate?
    
    var photos : [TFPhoto] = [TFPhoto]()
}

public class TFStory : NSObject {
    var story_id : String?
    var title : String?
    var desc : String?
    var recURL : String?
    var recordingText : String?
    var dateUploaded : NSDate?
    
}
public class TFPhoto : NSObject {
    
    var mainURL : String?
    var thumbURL : String?
    var id : String?
    var title : String?
    var dateTaken : NSDate?
    var dateConf : Float?
    var uploadedBy : String?
    var repoID : String?
    var dateUploaded : NSDate?
    var desc : String?
    
}
