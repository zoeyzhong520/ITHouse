//
//  NewsDetailNewsModel.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsDetailNewsModel: BaseModel {

    var news: Array<NewsDetailNew>?
    
    class func parseDict(dict: [String: Any]) -> NewsDetailNewsModel {
        let json = JSON(dict)
        let model = NewsDetailNewsModel()
        
        var array = [NewsDetailNew]()
        for (_, subjson) in json["news"] {
            let newModel = NewsDetailNew.parse(json: subjson)
            array.append(newModel)
        }
        model.news = array
        return model
    }
}

class NewsDetailNew: BaseModel {
    
    var img: String?
    var title: String?
    var createTime: String?
    var commentNum: String?
    
    class func parse(json: JSON) -> NewsDetailNew {
        let model = NewsDetailNew()
        model.img = json["img"].string
        model.title = json["title"].string
        model.createTime = json["createTime"].string
        model.commentNum = json["commentNum"].string
        return model
    }
}
