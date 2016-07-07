//
//  StoriesTableViewCell.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/6/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

class StoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var uploadedLabel : UILabel!
    @IBOutlet weak var uploadedTitle : UILabel!
    
    var didSetup = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
     func setThingsUp() {
        if self.didSetup == false
        {
            let titleFontSize : CGFloat = 10.0
            let descriptionFontSize : CGFloat = 8.0
            let uploadedLableFontSize : CGFloat = descriptionFontSize
            let uploadedTitleFontSize : CGFloat = titleFontSize
            
            
            let fontFamily = GlobalConfig.defaultFontFamily
            
            titleLable.font = UIFont(name: fontFamily, size: titleFontSize)
            titleLable.text = ""
            
            descriptionLabel.font = UIFont(name: fontFamily, size: descriptionFontSize)
            descriptionLabel.text = ""
            
            uploadedLabel.font = UIFont(name: fontFamily, size: uploadedLableFontSize)
            uploadedLabel.text = ""
            
            uploadedTitle.font = UIFont(name: fontFamily, size: uploadedTitleFontSize)
            
            self.didSetup = true
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    static let fixedHeight = 80.0;
    static let cellReuseID = "storiestableviewcell"
}
