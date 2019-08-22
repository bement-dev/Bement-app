//
//  AppDelegate.swift
//  Bement
//
//  Created by Runkai Zhang on 8/21/19.
//  Copyright © 2019 The Bement School. All rights reserved.
//

import UIKit
import CoreData
import FeedKit
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Social media data variables
    
    public static var instagramItems: [RSSFeedItem] = []
    public static var twitterItems: [RSSFeedItem] = []
    public static var facebookItems: [RSSFeedItem] = []

    // MARK: Application Handling
    
    /// Fires when the application is launched
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let instaURL = URL(string: "https://rss.app/feeds/vXhoCLgzZOUpWIhM.xml")!
        let instaParser = FeedParser(URL: instaURL)
        instaParser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            if result.isSuccess {
                for item in result.rssFeed!.items! {
                    AppDelegate.instagramItems.append(item)
                }
                ViewController.instagramRetrieved = true
            } else {
                ViewController.instagramRetrieved = false
                print(result.error!)
            }
        }

        let twitterURL = URL(string: "https://rss.app/feeds/3r2kmUvEXa9v77jH.xml")!
        let twitterParser = FeedParser(URL: twitterURL)
        twitterParser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            if result.isSuccess {
                for item in result.rssFeed!.items! {
                    AppDelegate.twitterItems.append(item)
                }
                ViewController.twitterRetrieved = true
            } else {
                ViewController.twitterRetrieved = false
                print(result.error!)
            }
        }
        
        let facebookURL = URL(string: "https://rss.app/feeds/q0MUQ8lpZOqiLsHx.xml")!
        let facebookParser = FeedParser(URL: facebookURL)
        facebookParser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            if result.isSuccess {
                for item in result.rssFeed!.items! {
                    AppDelegate.facebookItems.append(item)
                }
                ViewController.facebookRecieved = true
            } else {
                ViewController.facebookRecieved = false
                print(result.error!)
            }
        }
        
        return true
    }
    
    /// This method sets up the screen orientation, allowing different settings for different `ViewController`s.
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if let rootViewController = self.topViewControllerWithRootViewController(rootViewController: window?.rootViewController) {
            if rootViewController.responds(to: Selector(("canRotate"))) {
                // Unlock landscape view orientations for this view controller
                return .all
            }
        }
        
        // Only allow portrait (standard behaviour)
        return .portrait
    }
    
    /// This is a helper method for `application(_:supportedInterfaceOrientationsFor:)`.
    private func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
        if rootViewController == nil { return nil }
        if rootViewController.isKind(of: UITabBarController.self) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
        } else if rootViewController.isKind(of: UINavigationController.self) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
        } else if rootViewController.presentedViewController != nil {
            return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
        }
        return rootViewController
    }
}

