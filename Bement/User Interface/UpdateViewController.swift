//
//  UpdateViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/19/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import MarkdownView

class UpdateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "Update#\(GlobalVariable.row)", ofType: "md")!

        let mdView = MarkdownView()
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
        } catch {
            print(error)
        }
    }
}
