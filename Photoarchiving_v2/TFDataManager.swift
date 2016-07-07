//
//  TFDataManager.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit


public class TFDataManager {
    
    static let sharedInstance = TFDataManager()
    
    private lazy var dateHelper = TFDateHelper.sharedInstance
    
    private lazy var requestQueue = NSOperationQueue()
    
    private let apiKey = "DXQ4kGBH9b5hoT1IMZxpqai9RosriN7WLX05DCMNNS4bM6Uy5rYvCgEtE7VXV2TG"
    private let apiUse = "1"
    private let apiEndpoint = "http://40.86.85.30/cs4380/api/"
    
    
    init() {
        
    }
    
    public func getPhotosForRepository( repoID : String, completion : (result : [TFPhoto]?, error : NSError?) -> Void)
    {
        let urlString = apiEndpoint + "photo.php?r_id=" + repoID + "&ps_id=" + self.apiUse + "&request_type=repo-photos&range_type=all&auth_token=" + apiKey
        
        let url = NSURL(string: urlString)
        
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: self.requestQueue) { (response, data, error) in
            
            let resp : NSHTTPURLResponse = response as! NSHTTPURLResponse
            
            if (resp.statusCode == 200)
            {
                self.processPhotosFromData(data!, completion: { (photos, error) in
                    
                    if (error == nil)
                    {
                        completion(result: photos, error: nil)
                    }
                    else
                    {
                        completion(result: nil, error: error)
                    }
                })
            }
        }
    }
    public func getRepositoriesForUser( userID : String, completion : (result : [TFRepository]?, error : NSError?) -> Void)
    {
        let urlString = apiEndpoint + "repository.php?req_type=user_repos&ps_id=" + userID + "&auth_token=" + apiKey;
        
        let url = NSURL(string: urlString)
        
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: self.requestQueue) { (response, data, error) in
            
            let resp : NSHTTPURLResponse = response as! NSHTTPURLResponse
            
            if (resp.statusCode == 200)
            {
                self.processRepositoriesFromData(data!, completion: { (repos, error) in
                    
                    if (error == nil)
                    {
                        
                        completion(result: repos, error: nil)
                    }
                    else
                    {
                        completion(result: nil, error: error)
                    }
                })
            }
        }
        
    }
    
    private func processPhotosFromData( data : NSData , completion : (photos : [TFPhoto]?, error : NSError?) -> Void)
    {
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue : 0)) as! NSArray
        
        let jsonCount = json?.count
        
        var photos = [TFPhoto]()
        
        for i in 0...(jsonCount! - 1)
        {
            let dictVal : NSDictionary = json![i] as! NSDictionary
            
            var newPhoto = TFPhoto()
            
            newPhoto.dateConf = Float(dictVal["date_conf"] as! Float)
            newPhoto.dateTaken = self.dateHelper.getDateFromString(dictVal["date_taken"] as! String, dateType: TFDateFormatType.v1)
            newPhoto.title = dictVal["title"] as? String
            newPhoto.description = dictVal["description"] as? String
            newPhoto.dateUploaded = self.dateHelper.getDateFromString(dictVal["date_uploaded"] as! String, dateType: TFDateFormatType.api)
            newPhoto.mainURL = dictVal["large_url"] as? String
            newPhoto.thumbURL = dictVal["thumb_url"] as? String
            newPhoto.id = dictVal["p_id"]?.stringValue
            
            photos.append(newPhoto)
        }
        
        completion(photos : photos, error: nil)
    }
    private func processRepositoriesFromData( data : NSData , completion : (repos : [TFRepository]?, error : NSError?) -> Void)
    {
      
        
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue : 0)) as! NSArray
        
        let jsonCount = json?.count
        
        var repos = [TFRepository]()
        
        for i in 0...(jsonCount! - 1)
        {
            let dictVal : NSDictionary = json![i] as! NSDictionary
            
            var newRepo = TFRepository()
            
            newRepo.repo_id = dictVal["r_id"]?.stringValue
            newRepo.title = dictVal["name"] as? String
            newRepo.description = dictVal["description"] as? String
            newRepo.dateCreated = self.dateHelper.getDateFromString(dictVal["date_created"] as! String, dateType: TFDateFormatType.api)
            if let mnDate = dictVal["min_date"] as? String
            {
                newRepo.minDate = self.dateHelper.getDateFromString(mnDate, dateType: .v1)
            }
            else
            {
                newRepo.minDate = self.dateHelper.defaultMinDate()
            }
            
            if let mxDate = dictVal["max_date"] as? String
            {
                newRepo.maxDate = self.dateHelper.getDateFromString(mxDate, dateType: .v1)
            }
            else
            {
                newRepo.maxDate = self.dateHelper.defaultMaxDate()
            }
            
            repos.append(newRepo)
        }
        
        completion(repos: repos, error: nil)
        

    }

}


extension TFDataManager {
    
    
    
    
    
    
    
    
}