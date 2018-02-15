//
//  AppDelegate.swift
//  Dynamic Top Shelf
//
//  Created by Daniel Lima on 09/02/2018.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let initialViewController = window?.rootViewController as? ViewController else {return false}

        if let identifier = url.getQueryStringParameter(param: "identifier") {
            initialViewController.label.text = identifier
        } else {
            return false
        }

        return true
    }
}

