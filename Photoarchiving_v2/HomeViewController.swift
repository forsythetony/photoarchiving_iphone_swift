//
//  HomeViewController.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var reposTblView: UITableView!
    
    private lazy var userMan = TFUserManager.sharedInstance
    private lazy var dataMan = TFDataManager.sharedInstance
    
    private lazy var repos = [TFRepository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkUserLogin()
    }
    
    
    private func setupTableView() {
        self.reposTblView.delegate = self
        self.reposTblView.dataSource = self
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
            
            self.dataMan.getRepositoriesForUser("1", completion: { (result, error) in
                
                if(error == nil)
                {
                    
                    self.repos = result!
                    
                }
            })
            
        }
        
        
    }
    
    
    
    
    
    //  Tableview data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repos.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellReuseID = "cell"
        
        var cell : UITableViewCell! = self.reposTblView.dequeueReusableCellWithIdentifier(cellReuseID)
        
        if cell == nil
        {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellReuseID)
           
        }
        
        let repoInfo = self.repos[indexPath.row]
        cell?.textLabel?.textColor = UIColor.blackColor()
        cell?.textLabel?.text = "a;lskdjf;lkj"
        
        return cell
    }
    
    
}
