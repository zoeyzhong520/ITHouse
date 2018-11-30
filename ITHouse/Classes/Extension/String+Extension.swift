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
    
    ///资讯-栏目JSON文件名
    static var newsColumnsFileName: String {
        return "columns"
    }
    
    ///资讯banner的JSON文件名
    static var newsBannerFileName: String {
        return "newsBanner"
    }
    
    ///资讯-news的JSON文件名
    static var newsNewsFileName: String {
        return "news"
    }
    
    ///资讯-newsPhotoText的JSON文件名
    static var newsPhotoTextFileName: String {
        return "newsPhotoText"
    }
    
    ///资讯-newsRanking的JSON文件名
    static var newsRankingFileName: String {
        return "newsRanking"
    }
}
