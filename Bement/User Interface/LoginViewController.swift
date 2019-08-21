//
//  LoginViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/5/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var login: UIButton!
    @IBOutlet var passworldField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Tools.beautifulButton(login)
        
        passworldField.delegate = self
        
        if traitCollection.userInterfaceStyle == .dark {
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.toolbarTintColor = .white
        } else {
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.toolbarTintColor = .black
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            
            let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
                    
            if userInterfaceStyle == .dark {
                self.view.backgroundColor = .black
                
                IQKeyboardManager.shared.enable = true
                IQKeyboardManager.shared.toolbarTintColor = .white
            } else {
                self.view.backgroundColor = .white
                
                IQKeyboardManager.shared.enable = true
                IQKeyboardManager.shared.toolbarTintColor = .black
            }
        }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if passworldField.text!.isEmpty {
            self.performSegue(withIdentifier: "loggedIn", sender: self)
        } else {
            let alert = UIAlertController(title: "Password Incorrect!", message: "Please try again.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
