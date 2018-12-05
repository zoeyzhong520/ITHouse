//
//  NewsDetailHotReviewModel.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/12/2.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsDetailHotReviewModel: BaseModel {

    var newsHotReview: Array<NewsDetailHotReview>?
    
    class func parseDict(dict: [String: Any]) -> NewsDetailHotReviewModel {
        let json = JSON(dict)
        let model = NewsDetailHotReviewModel()
        
        var array = [NewsDetailHotReview]()
        for (_, subjson) in json["newsHotReview"] {
            let model = NewsDetailHotReview.parse(json: subjson)
            array.append(model)
        }
        model.newsHotReview = array
        
        return model
    }
    
    ///计算行高
    func newsHotReviewRowHeight() {
        guard let newsHotReview = newsHotReview else {
            fatalError("newsHotReview为nil")
        }
        
        for item in newsHotReview {
            let commentTextHeight = item.comment?.textHeight(withFont: UIFont.navTitleFont, andWidth: SCREEN_WIDTH - ITHouseScale(65), andLineSpacing: 5)
            let newsTitleHeight = item.newsTitle?.textHeight(withFont: UIFont.titleFont, andWidth: SCREEN_WIDTH - ITHouseScale(65), andLineSpacing: 5)
            
            let rowHeight = (commentTextHeight ?? 0) + (newsTitleHeight ?? 0)
            item.rowHeight = rowHeight + ITHouseScale(110)
            
            item.nickNameLabelWidth = item.nickName?.textWidth(font: UIFont.titleFont)
            item.deviceLabelWidth = item.device?.textWidth(font: UIFont.titleFont)
            item.opposeLabelWidth = "反对((\(item.oppose ?? ""))".textWidth(font: UIFont.textFont)
            item.standByLabelWidth = "支持((\(item.standBy ?? ""))".textWidth(font: UIFont.textFont)
        }
    }
}

class NewsDetailHotReview: BaseModel {
    
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
    var rowHeight: CGFloat?
    var nickNameLabelWidth: CGFloat?
    
    var deviceLabelWidth: CGFloat?
    var opposeLabelWidth: CGFloat?
    var standByLabelWidth: CGFloat?
    
    class func parse(json: JSON) -> NewsDetailHotReview {
        let model = NewsDetailHotReview()
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
        return model
    }
}
