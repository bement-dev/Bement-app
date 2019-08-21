//
//  DetailTableViewCell.swift
//  Bement
//
//  Created by Runkai Zhang on 8/3/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
