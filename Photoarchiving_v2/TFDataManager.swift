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
    private let apiUser = "1"
    private let apiEndpoint = "http://40.86.85.30/cs4380/api/"
    
    
    init() {
        
    }
    
    
    //  MARK: Data Retrieval Functions
    
    
    
    /**
        Retrieves all of the stories for a particular photograph
     
     - parameter photoID:       photoID ->  The identifier (string) for the photograph
                                completion ->   The completion block that either returns an array of processed stories or 
                                                an error if the stories could not be retrieved or processed
     - parameter completion:    This function does not return anything upon completion (aside from what it returns in the
                                completion block...)
     */
    public func getStoriesForPhoto( photoID : String, completion : (result : [TFStory]?, error : NSError?) -> Void)
    {
        let urlString = apiEndpoint + "story.php?p_id=" + photoID + "&ps_id=" + self.apiUser + "&request_type=photo-stories&auth_token=" + apiKey
        
        let url = NSURL(string: urlString)
        
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: self.requestQueue) { (response, data, error) in

            if response != nil
            {
                let resp : NSHTTPURLResponse = response as! NSHTTPURLResponse
                
                if (resp.statusCode == 200)
                {
                    self.processStoriesFromData(data!, completion: { (stories, error) in
                        
                        if error == nil
                        {
                            completion(result: stories, error: nil)
                        }
                        else
                        {
                            completion(result: nil, error: error)
                        }
                    })
                }
            }
            else
            {
                /*
                    Ideally it should print some error to the log but we don't really have logging set up yet...
                */
                
                let errorMessage = "Could not get a response for the request with the URL -> " + urlString
                
                print(errorMessage)
            }
            
        }
    }
    
    /**
        Retrieves all of the photographs from the API (currently it is using the default user)
     
     - parameter repoID:        repoID  ->      The identifier for the repository (string)
                                completion ->   The completion block that either returns (or rather passes back) an array
                                                of all the photographs that have been processed or an error.
     
     - parameter completion:    This function does not return anything upon completion (aside from what's returned in the completion 
                                block
     */
    public func getPhotosForRepository( repoID : String, completion : (result : [TFPhoto]?, error : NSError?) -> Void)
    {
        let urlString = apiEndpoint + "photo.php?r_id=" + repoID + "&ps_id=" + self.apiUser + "&request_type=repo-photos&range_type=all&auth_token=" + apiKey
        
        let url = NSURL(string: urlString)
        
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: self.requestQueue) { (response, data, error) in
            
            
            if response != nil
            {
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
            else
            {
                /*
                    Ideally it should print some error to the log but we don't really have logging set up yet...
                 */
                
                let errorMessage = "I couldn't get a reponse for the request with the URL -> " + urlString
                
                print(errorMessage)
            }
            
        }
    }
    
    /**
        Retrieves all of the repositories for a given user
     
     - parameter userID:        userID ->       The identifier (string) for the user
                                completion ->   The completion block that will either return (or rather pass as parameters in a block...)
                                                the result as an array of processed repository (TFRepository) objects or an error
     - parameter completion:    This function does not return anything upon completion
     */
    public func getRepositoriesForUser( userID : String, completion : (result : [TFRepository]?, error : NSError?) -> Void)
    {
        let urlString = apiEndpoint + "repository.php?req_type=user_repos&ps_id=" + userID + "&auth_token=" + apiKey;
        
        print(urlString)
        
        let url = NSURL(string: urlString)
        
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: self.requestQueue) { (response, data, error) in
            
            
            if response != nil
            {
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
            else
            {
                let errorMessage = "The response I got back was nil..."
                
                print(errorMessage)
            }
            
        }
        
    }
    
    
    //  MARK: Data Processing Functions
    
    
    
    /**
        Processes the stories the stories from the raw JSON data received from the API
     
     - parameter data:      data    ->      The raw NSData receieved from the request
                            completion ->   The completion block that returns either an array with all the processed 
                                            stories or an error
     
     - parameter completion:    This function does not return anything (except in the completion block...)
     */
    private func processStoriesFromData( data : NSData , completion : (stories : [TFStory]?, error : NSError?) -> Void)
    {
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue : 0)) as! NSArray
        
        let jsonCount = json?.count
        
        var stories = [TFStory]()
        if jsonCount == 0
        {
            completion(stories: stories, error: nil)
            return
        }
        
        for i in 0...(jsonCount! - 1)
        {
            let dictVal : NSDictionary = json![i] as! NSDictionary
            
            let newStory = TFStory()
            
            
            newStory.story_id = dictVal["s_id"]?.stringValue
            newStory.desc = dictVal["description"] as? String
            newStory.title = dictVal["title"] as? String
            newStory.recURL = dictVal["recording_url"] as? String
            newStory.recordingText = dictVal["recording_text"] as? String
            
            if let upDate = dictVal["date_uploaded"] as? String
            {
                newStory.dateUploaded = self.dateHelper.getDateFromString(upDate, dateType: .v1)
            }
            else
            {
                newStory.dateUploaded = self.dateHelper.defaultMaxDate()
            }
            
            stories.append(newStory)
        }
        
        completion(stories : stories, error: nil)
    }
    
    
    
    
    
    
    private func processPhotosFromData( data : NSData , completion : (photos : [TFPhoto]?, error : NSError?) -> Void)
    {
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue : 0)) as! NSArray
        
        let jsonCount = json?.count
        
        var photos = [TFPhoto]()
        
        for i in 0...(jsonCount! - 1)
        {
            let dictVal : NSDictionary = json![i] as! NSDictionary
            
            let newPhoto = TFPhoto()
            
            newPhoto.dateConf = Float(dictVal["date_conf"] as! Float)
            newPhoto.dateTaken = self.dateHelper.getDateFromString(dictVal["date_taken"] as! String, dateType: TFDateFormatType.v1)
            newPhoto.title = dictVal["title"] as? String
            newPhoto.desc = dictVal["description"] as? String
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