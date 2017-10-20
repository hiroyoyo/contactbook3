//
//  AppDelegate.swift
//  contactbook
//
//  Created by 佐野浩代 on 2017/09/06.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var id: String? = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        var flg = true
        
        //名前を指定して Storyboard を取得する(Main.storyboard の場合)
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        //「is initial view controller」が設定されている ViewController を取得する
        var viewController = storybord.instantiateInitialViewController()
        
        //
        if (id != nil) {
            //ホーム画面に遷移
            flg = true
        } else {
            flg = false
        }
        
        if flg {
            
            let main_storybord = UIStoryboard(name: "Main", bundle: nil)
            viewController = main_storybord.instantiateInitialViewController()
            
        } else {
            let registration_storybord = UIStoryboard(name: "registration", bundle: nil)
            viewController = registration_storybord.instantiateInitialViewController()
        }
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

