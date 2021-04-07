    //
//  CatalogTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 9/24/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit

/// A table to display all the library catalogs.
class CatalogTableViewController: UITableViewController {
    
    /// A number stored to pass onto the next `UIViewController`.
    var indexRow = Int()
    
    /// :nodoc:
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    /// Only one section, this is a constant.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Only ten rows, this is a constant.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    /// Segue to another table for more information whenever a row has been clicked.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 1:
            indexRow = indexPath.row
            self.performSegue(withIdentifier: "resource", sender: self)
        case 2:
            indexRow = indexPath.row
            self.performSegue(withIdentifier: "resource", sender: self)
        case 3:
            indexRow = indexPath.row
            self.performSegue(withIdentifier: "resource", sender: self)
        case 4:
            indexRow = indexPath.row
            self.performSegue(withIdentifier: "resource", sender: self)
        case 5:
            indexRow = indexPath.row
            self.performSegue(withIdentifier: "resource", sender: self)
        case 6:
            indexRow = indexPath.row
            self.performSegue(withIdentifier: "resource", sender: self)
        case 7:
            indexRow = indexPath.row
            self.performSegue(withIdentifier: "resource", sender: self)
        case 8:
            indexRow = indexPath.row
            self.performSegue(withIdentifier: "resource", sender: self)
        case 9:
            indexRow = indexPath.row
            self.performSegue(withIdentifier: "resource", sender: self)
        default:
            print("This is going to the library!")
        }
    }
    
    /// Sends the index data to `CatalogDetailTableViewController`.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "resource" {
            
            // Create a variable that you want to send
            let catalogID = indexRow
            
            let destinationVC = segue.destination as! CatalogDetailTableViewController
            destinationVC.segueData = catalogID
        }
    }
}
