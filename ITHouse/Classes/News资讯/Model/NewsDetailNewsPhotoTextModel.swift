//
//  NewsDetailNewsPhotoTextModel.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsDetailNewsPhotoTextModel: BaseModel {

    var newsPhotoText: Array<NewsDetailNewsPhotoText>?
    
    class func parseDict(dict: [String: Any]) -> NewsDetailNewsPhotoTextModel {
        let json = JSON(dict)
        let model = NewsDetailNewsPhotoTextModel()
        
        var array = [NewsDetailNewsPhotoText]()
        for (_, subjson) in json["newsPhotoText"] {
            let photoTextModel = NewsDetailNewsPhotoText.parse(json: subjson)
            array.append(photoTextModel)
        }
        model.newsPhotoText = array
        
        return model
    }
}

class NewsDetailNewsPhotoText: BaseModel {
    
    var images: Array<String>?
    var title:String?
    var createTime: String?
    var commentNum: String?
    
    class func parse(json: JSON) -> NewsDetailNewsPhotoText {
        let model = NewsDetailNewsPhotoText()
        
        var array = [String]()
        for (_, subjson) in json["images"] {
            if subjson.string != nil {
                array.append(subjson.string!)
            }
        }
        model.images = array
        
        model.title = json["title"].string
        model.createTime = json["createTime"].string
        model.commentNum = json["commentNum"].string
        return model
    }
}
