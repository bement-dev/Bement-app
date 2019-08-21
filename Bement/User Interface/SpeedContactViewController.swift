//
//  SpeedContactViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 6/23/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import MessageUI

class SpeedContactViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var costaCard: UIView!
    @IBOutlet var costaPhone: UIButton!
    @IBOutlet var costaEmail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        costaCard.layer.cornerRadius = 15
        
        costaPhone.layer.cornerRadius = 7
        costaEmail.layer.cornerRadius = 7
        
        costaEmail.setTitle(NSLocalizedString("email", comment: ""), for: .normal)
        costaPhone.setTitle(NSLocalizedString("phone", comment: ""), for: .normal)
    }
    
    @IBAction func costaPhoneClicked(_ sender: Any) {
        guard let number = URL(string: "tel://4137747061") else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func costaEmailClicked(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["tcosta@bement.org"])
            mail.setMessageBody("", isHTML: false)
            
            present(mail, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Your device cannot send emails.", preferredStyle: .alert)
            self.present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
                super.traitCollectionDidChange(previousTraitCollection)

                let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
                
                if userInterfaceStyle == .dark {
                    self.view.backgroundColor = .black
                } else {
                    self.view.backgroundColor = .white
                }
            }
}
