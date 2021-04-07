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
import Siren

@UIApplicationMain
/// :nodoc:
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Social media data variables
    
    /// A universally accessible `RSSFeedItem` list that stores posts from Twitter.
    public static var twitterItems: [RSSFeedItem] = []
    /// A universally accessible `RSSFeedItem` list that stores posts from Facebook.
    public static var facebookItems: [RSSFeedItem] = []

    // MARK: Application Handling
    
    /// Fires when the application is launched
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Siren.shared.wail()
        
        return true
    }
    
    /// This method sets up the screen orientation, allowing different settings for different `ViewController`s.
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if let rootViewController = self.topViewControllerWithRootViewController(rootViewController: window?.rootViewController) {
            if rootViewController.responds(to: #selector(ClagettViewController.canRotate)) {
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

