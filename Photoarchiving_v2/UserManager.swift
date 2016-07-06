//
//  UserManager.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit

public class TFUserManager {
    
    static let sharedInstance = TFUserManager()
    
    public var userInformation = UserInformation()
    
    
    init()
    {
        setupWithDefaultValues()
    }
    
    
    
    
    
    
    private func setupWithDefaultValues() {
        self.userInformation.userName = "forsythetony"
        self.userInformation.authKey = "DXQ4kGBH9b5hoT1IMZxpqai9RosriN7WLX05DCMNNS4bM6Uy5rYvCgEtE7VXV2TG"
        self.userInformation.userID = "1"
    }
    
    
    
    public struct UserInformation {
        
        public var userName : String?
        public var authKey : String?
        public var userID : String?
        
    }
}