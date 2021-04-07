//
//  Announcement.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

/// The `Announcement` object, allowing the saving process to be easier.
class Announcement {
    
    /// Whether or not the announcement is going to be displayed.
    var display = false
    /// The title for the announcement
    var titleString: String?
    /// The first line of the announcement
    var firstLine: String?
    /// The second line of the announcement
    var secondLine: String?
    
    /**
     The initiation of an `Announcement` object.
     - parameters:
        - display: A `Bool` that determines whether the announcement is going to be displayed.
        - titleString: The title for the announcement.
        - firstLine: The first line of the announcement.
        - secondLine: The second line of the announcement.
     */
    init(display: Bool, titleString: String?, firstLine: String?, secondLine: String?) {
        self.display = display
        self.titleString = titleString ?? ""
        self.firstLine = firstLine ?? ""
        self.secondLine = secondLine ?? ""
    }
    
    /**
     Upload a new record with the variables stored. If an error occured, then presume one already exist and try to update it.
     - warning: This version of this method is not designed to be error proof, but just made to work. Improvement is **required** to make this stable.
     - parameters:
        - sender: A `UIViewController` that is recieving and presenting the success message.
     */
    func upload(sender: UIViewController) {
        let id = CKRecord.ID(recordName: "0")
        let record = CKRecord(recordType: "Announcment", recordID: id)
        
        record["display"] = NSNumber(value: self.display)
        record["titleString"] = self.titleString
        record["firstLine"] = self.firstLine
        record["secondLine"] = self.secondLine
            
        let myContainer = CKContainer.default()
        let publicDatabase = myContainer.publicCloudDatabase
            
        publicDatabase.save(record) { (_, error) in
            if let error = error {
                print(error)
                self.update(sender: sender)
                return
            } else {
                DispatchQueue.main.sync {
                    let alert = UIAlertController(title: "Announcement Updated!", message: "Your changes has been saved", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(ok)
                    sender.present(alert, animated: true)
                }
            }
        }
    }
    
    /**
     The update method, designed to be its own function so that it can be used outside of the `upload(sender:)`'s scope.
     - warning: Using this method without the knowledge of whether a record already exists will result in inconsistency and errors.
     - parameters:
        - sender: A `UIViewController` that is recieving and presenting the success message.
     */
    func update(sender: UIViewController) {
        let myContainer = CKContainer.default()
        let publicDatabase = myContainer.publicCloudDatabase
        
        let recordID = CKRecord.ID(recordName: "0")

        publicDatabase.fetch(withRecordID: recordID) { record, error in

            if let record = record, error == nil {

                record.setObject(NSNumber(value: self.display), forKey: "display")
                record.setObject(NSString(utf8String: self.titleString ?? ""), forKey: "titleString")
                record.setObject(NSString(utf8String: self.firstLine ?? ""), forKey: "firstLine")
                record.setObject(NSString(utf8String: self.secondLine ?? ""), forKey: "secondLine")

                publicDatabase.save(record) { _, _ in
                    DispatchQueue.main.sync {
                        let alert = UIAlertController(title: "Announcement Updated!", message: "Your changes has been saved", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(ok)
                        sender.present(alert, animated: true)
                    }
                }
            }
        }
    }
}
