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

/// The configuration `ViewController` class for announcements.
class AnnouncementViewController: UIViewController {
    
    /// The button for saving the changes to the configuration.
    @IBOutlet var saveButton: UIButton!
    /// The switch to determine whether the announcement is going to be displayed.
    @IBOutlet var announcementSwitch: UISwitch!
    /// The `UITextField` for inputing the title of the announcement.
    @IBOutlet var titleField: UITextField!
    /// The `UITextField` for inputing the first line of the announcement.
    @IBOutlet var firstField: UITextField!
    /// The `UITextField` for inputing the second line of the announcement.
    @IBOutlet var secondField: UITextField!
    
    /// Set up the button after the screen is loaded.
    override func viewDidLoad() {
        super.viewDidLoad()

        Tools.beautifulButton(saveButton)
    }
    
    /// Disables the text fields if the switch is off, because it means that the announcement is not going to be displayed.
    @IBAction func switchSwitched(_ sender: UISwitch) {
        if sender.isOn {
            titleField.isEnabled = true
            firstField.isEnabled = true
            secondField.isEnabled = true
        } else {
            titleField.isEnabled = false
            firstField.isEnabled = false
            secondField.isEnabled = false
        }
    }
    
    /**
     Execute when `saveButton` is clicked.
     This method first check whether an iCloud account is logged into the device, if true, then it will try to upload the `Announcement` record.
    */
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
