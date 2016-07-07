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
            
            repos.append(newRepo)
        }
        
        completion(repos: repos, error: nil)
        

    }

}


extension TFDataManager {
    
    
    
    
    
    
    
    
}