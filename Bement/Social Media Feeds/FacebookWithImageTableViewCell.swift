//
//  InstagramTableViewCell.swift
//  Bement
//
//  Created by Runkai Zhang on 5/27/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit

class FacebookWithImageTableViewCell: UITableViewCell {
    
    @IBOutlet var dateOfPub: UILabel!
    @IBOutlet var contentImage: UIImageView!
    @IBOutlet var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentImage.layer.cornerRadius = 15
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
                
        if userInterfaceStyle == .dark {
        } else {
        }
    }
}
