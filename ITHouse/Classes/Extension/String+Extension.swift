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
    
    ///name
    static var nameKey: String {
        return "nameKey"
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
    
    ///资讯-newsHotReview的JSON文件名
    static var newsHotReviewFileName: String {
        return "newsHotReview"
    }
    
    ///资讯-newsCommentary的JSON文件名
    static var newsCommentaryFileName: String {
        return "newsCommentary"
    }
    
    ///搜索基础数据JSON文件名
    static var searchFileName: String {
        return "search"
    }
    
    ///搜索结果数据JSON文件名
    static var searchResultFileName: String {
        return "searchResult"
    }
    
    ///获取文本高度
    func textHeight(withFont font: UIFont, andWidth width: CGFloat) -> CGFloat {
        let rect = (self as NSString).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect.size.height
    }
    
    ///获取富文本高度
    func textHeight(withFont font: UIFont, andWidth width: CGFloat, andLineSpacing lineSpacing: CGFloat) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: font], range: NSMakeRange(0, self.count))
        
        let rect = attributedString.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil)
        return rect.size.height
    }
}
