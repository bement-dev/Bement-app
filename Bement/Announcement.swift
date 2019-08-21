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

class Announcement {
    var display = false
    var titleString: String?
    var firstLine: String?
    var secondLine: String?
    
    init(display: Bool, titleString: String?, firstLine: String?, secondLine: String?) {
        self.display = display
        self.titleString = titleString ?? ""
        self.firstLine = firstLine ?? ""
        self.secondLine = secondLine ?? ""
    }
    
    func upload(sender: UIViewController) {
        print("Upload Start")
        let id = CKRecord.ID(recordName: "0")
        let record = CKRecord(recordType: "Announcments", recordID: id)
        
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
                print("Upload end")
            }
        }
    }
    
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
