//
//  LookAheadViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 7/31/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import WebKit
import Fuzi

class LookAheadViewController: UIViewController {

    @IBOutlet var lookAheadView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURLString = "https://www.bement.org/students"
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let html = try String(contentsOf: myURL, encoding: .ascii)
            do {
                let doc = try HTMLDocument(string: html, encoding: String.Encoding.utf8)
                DispatchQueue.global().async {
                    let unedittedCode = doc.body?.children[3].children[1].children[0].children[2].children[0].children[0].children[0].children[3].children[1].children[0].children[2].children[0].description
                    
                    let startOffset = unedittedCode!.index(unedittedCode!.startIndex, offsetBy: 9)
                    let endOffset = unedittedCode!.index(unedittedCode!.endIndex, offsetBy: -37)
                    
                    let finalizedString = unedittedCode![startOffset...endOffset]
                    _ = DispatchQueue.main.sync {
                        self.lookAheadView.load(URLRequest(url: URL(string: String(finalizedString))!))
                    }
                }
            } catch let error {
              print(error)
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
}
