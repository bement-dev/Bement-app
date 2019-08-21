//
//  LunchViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 5/23/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class LunchViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    @objc func canRotate() {}
    var activityIndicator: UIActivityIndicatorView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.hidesWhenStopped = true
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setLeftBarButton(barButton, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://bementorg.finalsite.com/uploaded/PDF_Links/weeklymenu.pdf")!
        webView.load(URLRequest(url: url))
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            
        if self.isMovingFromParent {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
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
