//
//  InstagramTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 5/27/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import Kingfisher
import SkeletonView
import Fuzi

class InstagramTableViewController: UITableViewController {
    
    var reloaded1 = false
    var reloaded2 = false
    var reloaded3 = false
    var reloaded4 = false
    var reloaded5 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AppDelegate.instagramItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let datePub = formatter.string(from: AppDelegate.instagramItems[indexPath.row].pubDate!)
        
        let cellWithImage = tableView.dequeueReusableCell(withIdentifier: "cellWithImage", for: indexPath) as! InstagramWithImageTableViewCell
        
        cellWithImage.dateOfPub.text = "Date: \(datePub)"
        
        do {
            let doc = try HTMLDocument(string: AppDelegate.instagramItems[indexPath.row].description!, encoding: String.Encoding.utf8)
            if doc.body!.children[0].stringValue == "\n      \n      \n    " {
                cellWithImage.content.text = ""
            } else {
                cellWithImage.content.text = doc.body?.children[0].children[1].stringValue
            }
        } catch let error {
            print(error)
        }
        
        cellWithImage.contentImage.showAnimatedSkeleton()
        
        let url = URL(string: (AppDelegate.instagramItems[indexPath.row].enclosure?.attributes!.url)!)
        cellWithImage.contentImage.kf.setImage(
            with: url,
            options: [
                .scaleFactor(UIScreen.main.scale)
            ]) { _ in
            cellWithImage.contentImage.hideSkeleton()
        }
        
        if indexPath.row == 0 && !reloaded1 {
            tableView.reloadData()
            reloaded1.toggle()
        }
        
        if indexPath.row == 1 && !reloaded2 {
            tableView.reloadData()
            reloaded2.toggle()
        }
        
        if indexPath.row == 2 && !reloaded3 {
            tableView.reloadData()
            reloaded3.toggle()
        }
        
        if indexPath.row == 3 && !reloaded4 {
            tableView.reloadData()
            reloaded4.toggle()
        }
        
        if indexPath.row == 4 && !reloaded5 {
            tableView.reloadData()
            reloaded5.toggle()
        }
        
        return cellWithImage
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let link = URL(string: AppDelegate.instagramItems[indexPath.row].link!) {
          UIApplication.shared.open(link)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
        
        if userInterfaceStyle == .dark {
        } else {
        }
    }
}
