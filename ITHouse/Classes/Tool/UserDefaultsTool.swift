//
//  UserDefaultsTool.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/25.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class UserDefaultsTool: NSObject {

    static var userDefaults = UserDefaults.standard
    
    //MARK: - token
    
    ///设置token
    static func setToken(token: String) {
        userDefaults.setValue(token, forKey: String.tokenKey)
        userDefaults.synchronize()
    }
    
    ///获取token
    static func token() -> String {
        guard let token = userDefaults.object(forKey: String.tokenKey) as? String else {
            return ""
        }
        return token
    }
    
    //MARK: - name
    
    ///设置name
    static func setName(name: String) {
        userDefaults.set(name, forKey: String.nameKey)
        userDefaults.synchronize()
    }
    
    ///获取name
    static func name() -> String {
        guard let name = userDefaults.object(forKey: String.nameKey) as? String else {
            return ""
        }
        return name
    }
}
