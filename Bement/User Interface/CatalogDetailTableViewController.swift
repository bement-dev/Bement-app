//
//  CatalogDetailTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 10/31/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit

class CatalogDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var titleTextDetail: UINavigationItem!
    var segueData = Int()
    var catalogs = [String()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch segueData {
        case 1:
            titleTextDetail.title = "Kindergarten"
        case 2:
            titleTextDetail.title = "Grade 1"
        case 3:
            titleTextDetail.title = "Grade 2"
        case 4:
            titleTextDetail.title = "Grade 3"
        case 5:
            titleTextDetail.title = "Grade 4"
        case 6:
            titleTextDetail.title = "Grade 5"
        case 7:
            titleTextDetail.title = "Grade 6"
        case 8:
            titleTextDetail.title = "Grade 7"
        case 9:
            titleTextDetail.title = "Grade 8 & 9"
        default:
            print("This should not happen!")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segueData {
        case 1: return Catalog.Gradek3.count
        case 2: return Catalog.Gradek3.count
        case 3: return Catalog.Gradek3.count
        case 4: return Catalog.Gradek3.count
        case 5: return Catalog.Grade45.count
        case 6: return Catalog.Grade45.count
        case 7: return Catalog.Grade6.count
        case 8: return Catalog.Grade789.count
        case 9: return Catalog.Grade789.count
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as! DetailTableViewCell
        
        switch segueData {
        case 1: cell.title.text = Catalog.Gradek3[indexPath.row]
        case 2: cell.title.text = Catalog.Gradek3[indexPath.row]
        case 3: cell.title.text = Catalog.Gradek3[indexPath.row]
        case 4: cell.title.text = Catalog.Gradek3[indexPath.row]
        case 5: cell.title.text = Catalog.Grade45[indexPath.row]
        case 6: cell.title.text = Catalog.Grade45[indexPath.row]
        case 7: cell.title.text = Catalog.Grade6[indexPath.row]
        case 8: cell.title.text = Catalog.Grade789[indexPath.row]
        case 9: cell.title.text = Catalog.Grade789[indexPath.row]
        default:
            print("This should not happen!")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GlobalVariable.row = indexPath.row
        switch segueData {
        case 1:
            GlobalVariable.CatalogGrade = "Kindergarten"
        case 2:
            GlobalVariable.CatalogGrade = "Grade 1"
        case 3:
            GlobalVariable.CatalogGrade = "Grade 2"
        case 4:
            GlobalVariable.CatalogGrade = "Grade 3"
        case 5:
            GlobalVariable.CatalogGrade = "Grade 4"
        case 6:
            GlobalVariable.CatalogGrade = "Grade 5"
        case 7:
            GlobalVariable.CatalogGrade = "Grade 6"
        case 8:
            GlobalVariable.CatalogGrade = "Grade 7"
        case 9:
            GlobalVariable.CatalogGrade = "Grade 8 & 9"
        default:
            print("This should not happen!")
        }
        self.performSegue(withIdentifier: "toWeb", sender: self)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
            
        if userInterfaceStyle == .dark {
        } else {
        }
    }
}
