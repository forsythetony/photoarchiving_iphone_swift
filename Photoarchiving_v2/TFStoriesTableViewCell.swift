//
//  TFStoriesTableViewCell.swift
//  Photoarchiving_v2
//
//  Created by Tony Forsythe on 7/7/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

class TFStoriesTableViewCell: UITableViewCell {
    
    let titleLabel : UILabel!
    let descriptionTextbox : UITextView!
    let dateUploadedValue : UILabel!
    let controlsView : UIView!
    
    static let cellReuseID = "TFStoriesTableViewCellReuseID"
    static let cellHeight : CGFloat = 80.0
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        //  Globals
        let regularTextColor = UIColor.lightGrayColor()
        let emphasisTextColor = UIColor.whiteColor()
        
        
        
        //  Title Label
        let titleLabelFontSize : CGFloat = 25.0
        
        self.titleLabel = UILabel()
        self.titleLabel.textColor = emphasisTextColor
        self.titleLabel.font = UIFont.globalFontWithSize(titleLabelFontSize)
        self.titleLabel.text = "untitled"
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //  Description Text Box
        let descFontSize : CGFloat = 15.0
        self.descriptionTextbox = UITextView()
        self.descriptionTextbox.textColor = regularTextColor
        self.descriptionTextbox.font = UIFont.globalFontWithSize(descFontSize)
        self.descriptionTextbox.text = "No Description"
        self.descriptionTextbox.showsVerticalScrollIndicator = false
        self.descriptionTextbox.showsHorizontalScrollIndicator = false
        self.descriptionTextbox.backgroundColor = UIColor.clearColor()
        self.descriptionTextbox.editable = false
        self.descriptionTextbox.translatesAutoresizingMaskIntoConstraints = false
        
        //  Date Uploaded Value
        let dateUploadedFontSize : CGFloat = 15.0
        self.dateUploadedValue = UILabel()
        self.dateUploadedValue.textColor = regularTextColor
        self.dateUploadedValue.font = UIFont.globalFontWithSize(dateUploadedFontSize)
        self.dateUploadedValue.text = "yyyy-mm-dd"
        self.dateUploadedValue.translatesAutoresizingMaskIntoConstraints = false

        
        //  Controls View
        self.controlsView = UIView()
        self.controlsView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        self.backgroundColor = UIColor.clearColor()
        self.contentView.backgroundColor = UIColor.clearColor()
        
        //  Add all as subviews to content view
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionTextbox)
        self.contentView.addSubview(self.dateUploadedValue)
        self.contentView.addSubview(self.controlsView)
        
        let padding : CGFloat = 5.0
        
        
        //  Title Label
        let titleLabelHeight : CGFloat = 20.0
        
        //  Now add the constraints
        
        NSLayoutConstraint.activateConstraints([
            self.titleLabel.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor, constant: padding),
            self.titleLabel.heightAnchor.constraintEqualToConstant(titleLabelHeight),
            self.titleLabel.topAnchor.constraintEqualToAnchor(self.contentView.topAnchor, constant: padding),
            self.titleLabel.widthAnchor.constraintEqualToConstant(self.contentView.bounds.size.width * 0.7),
            self.descriptionTextbox.leadingAnchor.constraintEqualToAnchor(self.titleLabel.leadingAnchor, constant: 0.0),
            self.descriptionTextbox.topAnchor.constraintEqualToAnchor(self.titleLabel.bottomAnchor, constant: padding),
            self.descriptionTextbox.bottomAnchor.constraintEqualToAnchor(self.contentView.bottomAnchor, constant: -padding),
            self.descriptionTextbox.trailingAnchor.constraintEqualToAnchor(self.titleLabel.trailingAnchor, constant: 0.0),
            self.controlsView.topAnchor.constraintEqualToAnchor(self.titleLabel.topAnchor, constant: 0.0),
            self.controlsView.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: padding),
            self.controlsView.bottomAnchor.constraintEqualToAnchor(self.dateUploadedValue.topAnchor, constant: -padding),
            self.controlsView.leadingAnchor.constraintEqualToAnchor(self.descriptionTextbox.trailingAnchor, constant: padding),
            self.dateUploadedValue.leadingAnchor.constraintEqualToAnchor(self.controlsView.leadingAnchor, constant: 0.0),
            self.dateUploadedValue.heightAnchor.constraintEqualToAnchor(self.titleLabel.heightAnchor, constant: 0.0),
            self.dateUploadedValue.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: padding),
            self.dateUploadedValue.bottomAnchor.constraintEqualToAnchor(self.contentView.bottomAnchor, constant: -padding)
            
            ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
