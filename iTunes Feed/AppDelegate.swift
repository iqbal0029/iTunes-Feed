//
//  AppDelegate.swift
//  iTunes Feed
//
//  Created by Faisal Ikwal on 5/24/19.
//  Copyright © 2019 Faisal Ikwal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        RSSFeed.unarchiveRSSFeed()
        return true
    }

}
