//
//  ClagettViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 9/26/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import WebKit

class ClagettViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet var libraryView: WKWebView!
    @objc func canRotate() {}
    var activityIndicator: UIActivityIndicatorView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        libraryView = WKWebView(frame: .zero, configuration: webConfiguration)
        libraryView.uiDelegate = self
        view = libraryView
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.hidesWhenStopped = true
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://bementlibrary.follettdestiny.com/common/welcome.jsp?context=saas23_2000489")
        let myRequest = URLRequest(url: myURL!)
        libraryView.load(myRequest)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)

            let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
            
            if userInterfaceStyle == .dark {
            } else {
            }
        }
    
    func showActivityIndicator(show: Bool) {
        if show {
            // Start the loading animation
            activityIndicator.startAnimating()
        } else {
            // Stop the loading animation
            activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        showActivityIndicator(show: false)
    }
}
