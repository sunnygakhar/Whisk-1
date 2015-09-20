//
//  AppDelegate.swift
//  Whisk
//
//  Created by Mohammed Kumail Jaffer on 9/19/15.
//  Copyright © 2015 Mohammed Kumail Jaffer. All rights reserved.
//

import UIKit
import OAuth2

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var oauth2: OAuth2CodeGrant!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let settings = [
            "client_id": "HnyWt1_t0EgZUMr1rvpo6XX_2BsKDBqg",
            "client_secret": "YGjhj4J52i2fwjvzWOckKqjv8OCeYbWsv2C2zLLc",
            "authorize_uri": "https://login.uber.com/oauth/authorize",
            "token_uri": "https://login.uber.com/oauth/token",
            "redirect_uris": ["whisk://oauth/callback"],
            "keychain": false,     // if you DON'T want keychain integration
            "title": "Uber"  // optional title to show in views
            ] as OAuth2JSON
        oauth2 = OAuth2CodeGrant(settings: settings)
        oauth2.verbose = true
        return true
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject) -> Bool {
        
        oauth2.handleRedirectURL(url)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

