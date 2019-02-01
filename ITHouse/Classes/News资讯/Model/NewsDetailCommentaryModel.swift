//
//  NewsDetailCommentaryModel.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/21.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsDetailCommentaryModel: BaseModel {
    
    var newsCommentary: Array<NewsDetailCommentary>?
    var newsTitle: String?
    
    class func parseDict(dict: [String: Any]) -> NewsDetailCommentaryModel {
        let json = JSON(dict)
        let model = NewsDetailCommentaryModel()
        
        var array = [NewsDetailCommentary]()
        for (_, subjson) in json["newsCommentary"] {
            let model = NewsDetailCommentary.parse(json: subjson)
            array.append(model)
        }
        model.newsCommentary = array
        
        model.newsTitle = json["newsTitle"].string
        
        return model
    }
    
    ///计算行高
    func newsCommentaryRowHeight() {
        guard let newsHotReview = newsCommentary else {
            fatalError("newsCommentary为nil")
        }
        
        for item in newsHotReview {
            let commentTextHeight = item.comment?.textHeight(withFont: UIFont.navTitleFont, andWidth: SCREEN_WIDTH - ITHouseScale(65), andLineSpacing: 5)
            
            let rowHeight = (commentTextHeight ?? 0)
            item.rowHeight = rowHeight + ITHouseScale(110)
            
            let moreCommentaryTextHeight = item.comment?.textHeight(withFont: UIFont.navTitleFont, andWidth: SCREEN_WIDTH - ITHouseScale(65*2), andLineSpacing: 5)
            
            let moreCommentaryRowHeight = (moreCommentaryTextHeight ?? 0)
            item.moreCommentaryRowHeight = moreCommentaryRowHeight + ITHouseScale(80)
            
            item.nickNameLabelWidth = item.nickName?.textWidth(font: UIFont.titleFont)
            item.deviceLabelWidth = item.device?.textWidth(font: UIFont.titleFont)
            item.opposeLabelWidth = "反对((\(item.oppose ?? ""))".textWidth(font: UIFont.textFont)
            item.standByLabelWidth = "支持((\(item.standBy ?? ""))".textWidth(font: UIFont.textFont)
            item.subCommentNumLabelWidth = "展开((\(item.subCommentNum ?? ""))".textWidth(font: UIFont.textFont)
            item.levelLabelWidth = item.level?.textWidth(font: UIFont.textFont)
        }
    }
}

class NewsDetailCommentary: BaseModel {
    
    var img: String?
    var nickName: String?
    var introduction: String?
    
    var device: String?
    var comment: String?
    var newsTitle: String?
    
    var newsUrl: String?
    var createTime: String?
    var standBy: String?
    
    var oppose: String?
    var subCommentNum: String?
    var level: String?
    
    var rowHeight: CGFloat?
    var nickNameLabelWidth: CGFloat?
    var deviceLabelWidth: CGFloat?
    
    var opposeLabelWidth: CGFloat?
    var standByLabelWidth: CGFloat?
    var subCommentNumLabelWidth: CGFloat?
    
    var levelLabelWidth: CGFloat?
    var moreCommentaryRowHeight: CGFloat?
    
    class func parse(json: JSON) -> NewsDetailCommentary {
        let model = NewsDetailCommentary()
        model.img = json["img"].string
        model.nickName = json["nickName"].string
        model.introduction = json["introduction"].string
        
        model.device = json["device"].string
        model.comment = json["comment"].string
        model.newsTitle = json["newsTitle"].string
        
        model.newsUrl = json["newsUrl"].string
        model.createTime = json["createTime"].string
        model.standBy = json["standBy"].string
        
        model.oppose = json["oppose"].string
        model.level = json["level"].string
        model.subCommentNum = json["subCommentNum"].string
        return model
    }
}
