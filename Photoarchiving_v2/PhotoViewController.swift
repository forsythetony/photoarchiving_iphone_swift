//
//  PhotoViewController.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mainImageView : UIImageView?
    var storiesTableView : UITableView!
    var swipeDownGestureRecognizer : UISwipeGestureRecognizer!
    
    var photoStories : [TFStory] = [TFStory]()
    
    var photoInfo : TFPhoto?
    
    lazy var dateHelper = TFDateHelper.sharedInstance
    lazy var dataMan = TFDataManager.sharedInstance
    private let audioMan = TFAudioManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getStories()
    }
    
    private func setupImageView() {
        
        let imgViewHeight = self.view.frame.size.height * 0.4
        
        
        self.mainImageView = UIImageView()
        
        self.view.addSubview(self.mainImageView!)
        
        if let imgView = self.mainImageView
        {
            imgView.translatesAutoresizingMaskIntoConstraints = false
            imgView.contentMode = UIViewContentMode.ScaleAspectFit
            
            
            NSLayoutConstraint.activateConstraints([
                imgView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor),
                imgView.topAnchor.constraintEqualToAnchor(self.topLayoutGuide.bottomAnchor),
                imgView.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor),
                imgView.heightAnchor.constraintEqualToConstant(imgViewHeight)
                ])
        }
        
        if let phtInfo = self.photoInfo
        {
            downloadImage(NSURL(string: phtInfo.mainURL!)!)
        }
        
        
        //  Set up the gesture recognizer
        
        self.swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PhotoViewController.respondToSwipeGesture(_:)))
        self.swipeDownGestureRecognizer.direction = .Down
        
        self.view.addGestureRecognizer(self.swipeDownGestureRecognizer)
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setupViews()
        
    }
    
    private func setupViews() {
        
        setupImageView()
        setupTableView()
        self.view.backgroundColor = Color.patternedOrchid()
    }
    
    private func setupTableView() {
        
        let tblView = UITableView()
        
        tblView.delegate = self
        tblView.dataSource = self
        
        tblView.registerClass(TFStoriesTableViewCell.self, forCellReuseIdentifier: TFStoriesTableViewCell.cellReuseID)
        
        self.view.addSubview(tblView)
        
        
        tblView.backgroundColor = Color.patternedTweed()
        tblView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        tblView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints([
            tblView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor),
            tblView.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor),
            tblView.bottomAnchor.constraintEqualToAnchor(self.bottomLayoutGuide.topAnchor),
            tblView.topAnchor.constraintEqualToAnchor(self.mainImageView!.bottomAnchor)
            ])
        
        self.storiesTableView = tblView
        
        
    }
    private func getStories() {
        
        dataMan.getStoriesForPhoto((self.photoInfo?.id)!) { (result, error) in
            
            if error == nil
            {
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.photoStories.appendContentsOf(result!)
                    
                    self.storiesTableView.reloadData()
                })
                
            }
        }
    }
    private func getDataFromURL( url : NSURL, completion: ((data : NSData?, response : NSURLResponse?, error : NSError?) -> Void)) {
        
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
        
    }
    
    private func downloadImage(url: NSURL) {
        
        getDataFromURL(url) { (data, response, error) in
            guard let data = data where error == nil else { return }
            dispatch_async(dispatch_get_main_queue(), {
                self.mainImageView!.image = UIImage(data: data)
            })
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return TFStoriesTableViewCell.cellHeight
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photoStories.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : TFStoriesTableViewCell = self.storiesTableView.dequeueReusableCellWithIdentifier(TFStoriesTableViewCell.cellReuseID, forIndexPath: indexPath) as! TFStoriesTableViewCell
        
        let story = self.photoStories[indexPath.row]
        
        
        cell.titleLabel.text = story.title
        
        if let desc = story.recURL
        {
            if desc == ""
            {
                cell.descriptionTextbox.text = "No description..."
            }
            else
            {
                cell.descriptionTextbox.text = desc
            }
        }
        
        
        if let dateUp = story.dateUploaded
        {
            cell.dateUploadedValue.text = self.dateHelper.getAPIStringFromDate(dateUp)
        }
        
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let story = self.photoStories[indexPath.row]
        
        self.audioMan.playAudioFromStory(story)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    
    func respondToSwipeGesture( gesture : UISwipeGestureRecognizer)
    {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: { 
            print("Nothing")
        })
    }
}
