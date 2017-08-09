//
//  AppDelegate.swift
//  Dungeon Contacts
//
//  Created by Simeon on 10/8/17.
//  Copyright © 2017 Two Lives Left. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            
        let initialView = DungeonPalsState.initialState.viewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.tintColor = #colorLiteral(red: 1, green: 0.4186053241, blue: 0.2168402778, alpha: 1)
        window?.rootViewController = initialView
        window?.makeKeyAndVisible()
        
        return true
    }

}

