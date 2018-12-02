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
        for (_, subjson) in json[""] {
            let model = NewsDetailHotReview.parse(json: subjson)
            array.append(model)
        }
        model.newsHotReview = array
        
        return model
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
