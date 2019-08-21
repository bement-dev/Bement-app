//
//  LoginViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import SwiftyJSON

class ContactBementViewController: UIViewController {
    
    @IBOutlet var inquireButton: UIButton!
    @IBOutlet var contactButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Tools.beautifulButton(inquireButton)
        Tools.beautifulButton(contactButton)
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
