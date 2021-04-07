//
//  imageTableViewCell.swift
//  Bement
//
//  Created by Runkai Zhang on 5/27/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit

/**
 A `UITableViewCell` that displays a date, a image, and some texts
*/
class imageTableViewCell: UITableViewCell {
    
    /// The label to display the date of publication.
    @IBOutlet var dateOfPub: UILabel!
    /// The image that is published within the post.
    @IBOutlet var contentImage: UIImageView!
    /// The body text that came with the post.
    @IBOutlet var content: UILabel!
    
    /// Setting the corner radius when the `imageTableViewCell` is initialized.
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentImage.layer.cornerRadius = 15
    }
}
