//
//  UpdateViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/19/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import WebKit
import SafariServices
import MarkdownView

class UpdateViewController: UIViewController, WKNavigationDelegate {
    
    let mdView = MarkdownView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "Update#\(GlobalVariable.row)", ofType: "md")!
        
        view.addSubview(mdView)
        mdView.translatesAutoresizingMaskIntoConstraints = false
        mdView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mdView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mdView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mdView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        do {
            let url = URL(fileURLWithPath: path)
            let markdown = try String(contentsOf: url, encoding: String.Encoding.utf8)
            mdView.load(markdown: markdown, enableImage: true)
            
            mdView.isScrollEnabled = true;
            mdView.backgroundColor = #colorLiteral(red: 0.1330000013, green: 0.1330000013, blue: 0.1330000013, alpha: 1);

            // called when user touch link
            mdView.onTouchLink = { [weak self] request in
              guard let url = request.url else { return false }

              if url.scheme == "file" {
                return false
              } else if url.scheme == "https" {
                let safari = SFSafariViewController(url: url)
                self?.navigationController?.pushViewController(safari, animated: true)
                return false
              } else {
                return false
              }
            }
        } catch {
            print(error)
        }
    }
}
