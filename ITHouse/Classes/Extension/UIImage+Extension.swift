//
//  UIImage+Extension.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

extension UIImage {
    
    ///返回箭头
    static var backImg: UIImage? {
        return UIImage(named: "backImg")
    }
    
    ///Logo图标
    static var logoImg: UIImage? {
        return UIImage(named: "news")
    }
    
    ///输入账号的左侧图标
    static var accountImg: UIImage? {
        return UIImage(named: "profile")
    }
    
    ///输入密码的左侧图标
    static var passwordImg: UIImage? {
        return UIImage(named: "passwordImg")
    }
    
    ///密码明文图标
    static var secureEntryImg: UIImage? {
        return UIImage(named: "secureEntryImg")
    }
    
    ///添加图标
    static var addImg: UIImage? {
        return UIImage(named: "addImg")
    }
    
    ///日历图标
    static var calendarImg: UIImage? {
        return UIImage(named: "calendarImg")
    }
    
    ///搜索图标
    static var searchImg: UIImage? {
        return UIImage(named: "searchImg")
    }
}
