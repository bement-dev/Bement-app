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

class LookAheadViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var lookAheadView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lookAheadView.navigationDelegate = self
        
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
                    
                    // I swear if this code is outdated one day due to the fact that Bement modified their website, imma gonna be mad!
                    let unedittedCode = doc.body?.children[3].children[1].children[0].children[2].children[0].children[0].children[0].children[3].children[1].children[0].children[2].children[0].description
                    
                    let startOffset = unedittedCode!.index(unedittedCode!.startIndex, offsetBy: 9)
                    let endOffset = unedittedCode!.index(unedittedCode!.endIndex, offsetBy: -97)
                    
                    let finalizedString = unedittedCode![startOffset...endOffset]
                    DispatchQueue.main.sync {
                        print(String(finalizedString));
                        if let link = URL(string: String(finalizedString)) {
                            self.lookAheadView.load(URLRequest(url: link))
                        }
                    }
                }
            } catch let error {
              print(error)
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url,
                let host = url.host, !host.hasPrefix("www.google.com"),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                print(url)
                print("Redirected to browser. No need to open it locally")
                decisionHandler(.cancel)
            } else {
                print("Open it locally")
                decisionHandler(.allow)
            }
        } else {
            print("not a user click")
            decisionHandler(.allow)
        }
    }
}
