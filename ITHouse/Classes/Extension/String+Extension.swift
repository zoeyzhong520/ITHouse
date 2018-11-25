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
    
    ///根据文本获取宽度
    func textWidth(font: UIFont) -> CGFloat {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font : font]).width + 2
    }
}
