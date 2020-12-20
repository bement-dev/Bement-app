//
//  SpeedContactViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 6/23/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import MessageUI

// Admission Office with phone 413-774-4209 and email admit@bement.org. Business Office with phone 413-774-7061 and email jboyden@bement.org

class SpeedContactViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var costaCard: UIView!
    @IBOutlet var admitCard: UIView!
    @IBOutlet var busiCard: UIView!
    @IBOutlet var nurseCard: UIView!
    @IBOutlet var afterCard: UIView!
    
    @IBOutlet var costaPhone: UIButton!
    @IBOutlet var admitPhone: UIButton!
    @IBOutlet var busiPhone: UIButton!
    @IBOutlet var nursePhone: UIButton!
    @IBOutlet var afterPhone: UIButton!
    
    @IBOutlet var costaEmail: UIButton!
    @IBOutlet var admitEmail: UIButton!
    @IBOutlet var busiEmail: UIButton!
    @IBOutlet var nurseEmail: UIButton!
    @IBOutlet var afterEmail: UIButton!
    
    @IBOutlet var emailsGroup: [UIButton]!
    @IBOutlet var phoneGroup: [UIButton]!
    @IBOutlet var cardGroup: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for card in cardGroup {
            card.layer.cornerRadius = 15
        }
        
        for button in emailsGroup {
            button.setTitle(NSLocalizedString("email", comment: ""), for: .normal)
            button.layer.cornerRadius = 7
        }
        
        for button in phoneGroup {
            button.setTitle(NSLocalizedString("phone", comment: ""), for: .normal)
            button.layer.cornerRadius = 7
        }
    }
    
    @IBAction func phoneClicked(_ sender: UIButton) {
        switch sender {
        case costaPhone:
            guard let number = URL(string: "tel://4137735967") else { return }
            UIApplication.shared.open(number)
        case admitPhone:
            guard let number = URL(string: "tel://4137744209") else { return }
            UIApplication.shared.open(number)
        case busiPhone:
            guard let number = URL(string: "tel://4137747061") else { return }
            UIApplication.shared.open(number)
        case nursePhone:
            guard let number = URL(string: "tel://4137747061,503") else { return }
            UIApplication.shared.open(number)
        case afterPhone:
            guard let number = URL(string: "tel://4137747061,126") else { return }
            UIApplication.shared.open(number)
        default:
            print("This should not happen!")
        }
    }
    
    func composeEmail(to recipients: [String]) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(recipients)
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
    
    @IBAction func emailClicked(_ sender: UIButton) {
        switch sender {
        case costaEmail:
            composeEmail(to: ["tcosta@bement.org"])
        case admitEmail:
            composeEmail(to: ["admit@bement.org"])
        case busiEmail:
            composeEmail(to: ["jboyden@bement.org"])
        case nurseEmail:
            composeEmail(to: ["shs@bement.org"])
        case afterEmail:
            composeEmail(to: ["kmaccallum@bement.org"])
        default:
            print("This should not happen!")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
        
        if userInterfaceStyle == .dark {
        } else {
        }
    }
}
