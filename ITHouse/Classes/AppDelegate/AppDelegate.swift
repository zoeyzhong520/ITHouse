//
//  AppDelegate.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD
import MJExtension

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    ///适配比例
    private(set) var fontSize:CGFloat = 0
    
    ///根据传入尺寸获取缩放比例
    func fontSizeScale(scale: CGFloat) -> CGFloat {
        return fontSize * scale
    }
    
    ///根据屏幕尺寸获取缩放比例
    fileprivate func fontSizeScale() {
        if iPhone7P || iPhoneXR || iPhoneXsMax {
            fontSize = 1.1
        } else if iPhone7 || iPhoneXs {
            fontSize = 1.0
        } else if iPhoneSE {
            fontSize = 0.9
        } else if iPhone4s {
            fontSize = 0.7
        } else {
            fontSize = 1.5
        }
    }
    
    ///设置根视图
    fileprivate func setRootVC() {
        window = UIWindow(frame: SCREEN_RECT)
        window?.rootViewController = MainTabBarViewController()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        fontSizeScale()
        
        setRootVC()
        
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        
        DBManager.shared().createTable()
        
        ITHouseHttpTool.newsColumnsData()
        
        Thread.sleep(forTimeInterval: 3.0)
        
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

