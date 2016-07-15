//
//  HomeViewController.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /// Outlet version, this should be replaced by one that's created in
    /// code
    @IBOutlet weak var reposTblView: UITableView!
    
    /// This should be the new tableview used
    private let reposTableView : UITableView = UITableView()
    
    private let reposTitleLabel : UILabel = UILabel()
    
    /*
        Singleton Managers
    */
    
    /// The user manager, this should be used to handle all CRUD operations on
    /// user information
    let userMan = TFUserManager.sharedInstance
    
    /// The data manager, this should be used to handle all networking calls
    let dataMan = TFDataManager.sharedInstance
    
    
    private var didLoadPhotos = false
    
    var repos : [TFRepository] = [TFRepository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customSetupViews()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkUserLogin()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
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
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
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
    
    
    // MARK: Custom Initialization and Subview Layout
    
    
    /**
     Sets up the tableview
     */
    private func customSetupViews() {
        
        /*
            Repos TableView
        */
        
        //  Old way
        self.reposTblView.delegate = self
        self.reposTblView.dataSource = self
        
        //  New way
        self.reposTableView.delegate    = self
        self.reposTableView.dataSource  = self
        
        self.reposTableView.separatorStyle = .None
        
        
        
        
        /*
            Repos Title Label
        */
        
        let reposTitleLabelText                 = "My Repositories"
        let reposTitleLabelFontSize : CGFloat   = 15.0
        let reposTitleLabelFontColor            = Color.darkGrayColor()
        
        self.reposTitleLabel.text = reposTitleLabelText
        self.reposTitleLabel.font = UIFont.globalFontWithSize(reposTitleLabelFontSize)
        self.reposTitleLabel.textColor = reposTitleLabelFontColor
        
        
        
    }
    
    private func customSetupSubviews() {
        
        /*
            Constants
        */
        
        let reposTitleLabelHeight : CGFloat         = 50.0
        let topPadding : CGFloat                    = 20.0
        let verticalViewsPadding : CGFloat          = 10.0
        let horizontalPadding : CGFloat             = 10.0
        let bottomPadding : CGFloat                 = 10.0
        
        let mainView    = self.view
        let lView       = self.reposTitleLabel
        let tView       = self.reposTableView
        
        let tlg = self.topLayoutGuide
        let blg = self.bottomLayoutGuide
        
        /*
            Adding subviews
        */
        mainView.addSubview(lView)
        mainView.addSubview(tView)
        
        
        /*
            Adding constraints
        */
        var layoutConstraints : [NSLayoutConstraint] = [NSLayoutConstraint]()
        
        
        //  Title Label
        layoutConstraints.append(lView.heightAnchor.constraintEqualToConstant(reposTitleLabelHeight))
        layoutConstraints.append(lView.leadingAnchor.constraintEqualToAnchor(mainView.leadingAnchor, constant: horizontalPadding))
        layoutConstraints.append(lView.trailingAnchor.constraintEqualToAnchor(mainView.trailingAnchor, constant: horizontalPadding))
        layoutConstraints.append(lView.topAnchor.constraintEqualToAnchor(tlg.bottomAnchor, constant: topPadding))
        
        //  Title Label & Table View
        layoutConstraints.append(lView.bottomAnchor.constraintEqualToAnchor(tView.topAnchor, constant: verticalViewsPadding))
        
        //  Table View
        layoutConstraints.append(tView.leadingAnchor.constraintEqualToAnchor(mainView.leadingAnchor, constant: horizontalPadding))
        layoutConstraints.append(tView.trailingAnchor.constraintEqualToAnchor(mainView.trailingAnchor, constant: horizontalPadding))
        layoutConstraints.append(tView.bottomAnchor.constraintEqualToAnchor(blg.topAnchor, constant: bottomPadding))
        
        
        NSLayoutConstraint.activateConstraints(layoutConstraints)

    }
}
