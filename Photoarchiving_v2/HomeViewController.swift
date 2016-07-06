//
//  HomeViewController.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private lazy var userMan = TFUserManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkUserLogin()
    }
    
    
    private func checkUserLogin() {
        
        if (!self.userMan.loginInformation.isLoggedIn!)
        {
            //  Redirect to login page
            let loginVC = LoginViewController()
            
            self.presentViewController(loginVC, animated: true, completion: {
                //  Do nothing
            });
        }
        else
        {
            
            
        }
        
        
    }
}
