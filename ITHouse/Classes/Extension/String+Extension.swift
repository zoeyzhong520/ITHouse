//
//  String+Extension.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

extension String {
    
    ///AppName
    static var AppName: String? {
        return Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String
    }
    
    ///tokenKey
    static var tokenKey: String {
        return "tokenKey"
    }
}
