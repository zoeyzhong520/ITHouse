//
//  MainTabBarViewController.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabArray = [["title":"资讯","img":"news","className":"NewsViewController"],["title":"辣品","img":"spicy","className":"SpicyViewController"],["title":"圈子","img":"circle","className":"CircleViewController"],["title":"我","img":"profile","className":"ProfileViewController"]]
        
        for (index, obj) in tabArray.enumerated() {
            let className = String.AppName! + "." + obj["className"]!
            let t_class = NSClassFromString(className) as! UIViewController.Type
            let vc = t_class.init()
            
            if index != tabArray.count - 1 {
                let leftBarButtonItem = UIBarButtonItem(title: index == 0 ? "ITHouse" : obj["title"]!, style: .plain, target: nil, action: nil)
                leftBarButtonItem.tintColor = UIColor.mainColor
                vc.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
            
            let navVC = BaseNavigationViewController(rootViewController: vc)
            let tabItem = UITabBarItem(title: obj["title"]!, image: UIImage(named: obj["img"]!), tag: index)
            navVC.tabBarItem = tabItem
            tabBar.tintColor = UIColor.mainColor
            addChild(navVC)
        }
        
        selectedIndex = 0
    }
}

