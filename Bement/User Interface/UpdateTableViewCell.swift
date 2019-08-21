//
//  UpdateTableViewCell.swift
//  Bement
//
//  Created by Runkai Zhang on 8/19/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit

class UpdateTableViewCell: UITableViewCell {

    @IBOutlet var updateImage: UIImageView!
    @IBOutlet var updateTitle: UILabel!
    @IBOutlet var updateDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
