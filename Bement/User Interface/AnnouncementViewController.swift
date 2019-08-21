//
//  AnnouncementViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import CloudKit
import Reachability

class AnnouncementViewController: UIViewController {
    
    @IBOutlet var currentAnnouncement: UILabel!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var announcementSwitch: UISwitch!
    @IBOutlet var titleField: UITextField!
    @IBOutlet var firstField: UITextField!
    @IBOutlet var secondField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Tools.beautifulButton(saveButton)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        CKContainer.default().accountStatus(completionHandler: { accountStatus, _ in
            if accountStatus == .noAccount {
                DispatchQueue.main.sync {
                    let alert = UIAlertController(title: "Sign in to iCloud", message: "Sign in to your iCloud account to write records. On the Home screen, launch Settings, tap iCloud, and enter your Apple ID. Turn iCloud Drive on. If you don't have an iCloud account, tap Create a new Apple ID.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            } else {
                DispatchQueue.main.sync {
                    if self.announcementSwitch.isOn {
                        if self.titleField.text!.isEmpty {
                            let data = Announcement(display: self.announcementSwitch.isOn, titleString: self.titleField.text!, firstLine: self.firstField.text, secondLine: self.secondField.text)
                            data.upload(sender: self)
                        } else {
                            let alert = UIAlertController(title: "Oops...", message: "You need to type something in the Title field.", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                            
                            alert.addAction(ok)
                            self.present(alert, animated: true)
                        }
                    } else {
                        let data = Announcement(display: self.announcementSwitch.isOn, titleString: self.titleField.text!, firstLine: self.firstField.text, secondLine: self.secondField.text)
                        data.upload(sender: self)
                    }
                }
            }
        })
    }
}
