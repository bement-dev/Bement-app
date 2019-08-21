//
//  UpdateTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/19/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit

class UpdateTableViewController: UITableViewController {

    let numberOfUpdates = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfUpdates
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UpdateTableViewCell
        
        cell.updateTitle.text = "Update#\(indexPath.row)"
        cell.updateDate.text = "Today"
        cell.updateImage.image = UIImage(named: "\(indexPath.row)")
        
        GlobalVariable.row = indexPath.row
        return cell
    }
}
