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
    
    ///计算行高
    func newsPhotoTextRowHeight() {
        guard let newsPhotoText = newsPhotoText else {
            fatalError("newsPhotoText为nil")
        }
        
        for item in newsPhotoText {
            let rowHeiht = (item.title?.textHeight(withFont: UIFont.navTitleFont, andWidth: SCREEN_WIDTH - ITHouseScale(30), andLineSpacing: 5) ?? 0) + ITHouseScale(130)
            item.rowHeight = rowHeiht
        }
    }
}

class NewsDetailNewsPhotoText: BaseModel {
    
    var images: Array<String>?
    var title:String?
    var createTime: String?
    var commentNum: String?
    var rowHeight: CGFloat?//行高
    
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
