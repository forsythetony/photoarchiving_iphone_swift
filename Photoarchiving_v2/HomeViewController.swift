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
    
    private var didLoadPhotos = false
    
    var repos : [TFRepository] = [TFRepository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        
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
            if(!self.didLoadPhotos)
            {
                self.dataMan.getRepositoriesForUser("1", completion: { (result, error) in
                    
                    if(error == nil)
                    {
                        
                        dispatch_async(dispatch_get_main_queue(), { 
                            self.reposTblView.beginUpdates()
                            
                            let startIndexPath : Int = self.repos.count
                            
                            var indexPaths = [NSIndexPath]()
                            
                            for i in 0...((result?.count)! - 1)
                            {
                                let newIndexPath = NSIndexPath(forRow: i + startIndexPath, inSection: 0)
                                indexPaths.append(newIndexPath)
                            }
                            
                            self.repos.appendContentsOf(result!)
                            
                            self.reposTblView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
                            
                            self.reposTblView.endUpdates()
                            
                            self.didLoadPhotos = true;
                        })
                        
                    }
                    
                    
                })
            }
            
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
        cell.backgroundColor = UIColor.orangeColor()
        cell?.textLabel?.text = repoInfo.title
        
        return cell
    }
    
    
    //  Tableview Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("pushToRepoView", sender: indexPath.row)
        
    }
    
    //  Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "pushToRepoView"
        {
            let destVC = segue.destinationViewController as! RepoViewController
            
            destVC.repoInfo = self.repos[sender as! Int]
        }
    }
    
}
