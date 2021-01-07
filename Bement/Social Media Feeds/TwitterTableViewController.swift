//
//  TwitterTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 5/27/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import Kingfisher
import FeedKit

class TwitterTableViewController: UITableViewController {
    
    var reloadCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AppDelegate.twitterItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let datePub = formatter.string(from: AppDelegate.twitterItems[indexPath.row].pubDate!)
        
        let cellWithImage = tableView.dequeueReusableCell(withIdentifier: "cellWithImage", for: indexPath) as! TwitterWithImageTableViewCell
        
        cellWithImage.selectionStyle = .none
        cellWithImage.dateOfPub.text = "Date: \(datePub)"
        
        if AppDelegate.twitterItems[indexPath.row].title == nil {
            cellWithImage.content.removeFromSuperview()
        } else {
            cellWithImage.content.text = AppDelegate.twitterItems[indexPath.row].title
        }
        
        let processor = RoundCornerImageProcessor(cornerRadius: 15)
        
        if let url = AppDelegate.twitterItems[indexPath.row].enclosure?.attributes!.url {
            cellWithImage.contentImage.kf.setImage(
                with: URL(string: url),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .processor(processor)
                ], completionHandler: { [self] _ in
                    if reloadCount != 5 {
                        reloadCount += 1
                        tableView.reloadData()
                    }
                })
        } else {
            cellWithImage.contentImage.removeFromSuperview()
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        return cellWithImage
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellWithImage = tableView.dequeueReusableCell(withIdentifier: "cellWithImage", for: indexPath) as! TwitterWithImageTableViewCell
        cellWithImage.contentImage.kf.cancelDownloadTask()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let link = URL(string: AppDelegate.twitterItems[indexPath.row].link!) {
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
