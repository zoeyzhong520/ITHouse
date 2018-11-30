//
//  NewsDetailNewsRankingModel.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsDetailNewsRankingModel: BaseModel {

    var newsRanking: Array<NewsDetailNewsRanking>?
    
    class func parseDict(dict: [String: Any]) -> NewsDetailNewsRankingModel {
        let json = JSON(dict)
        let model = NewsDetailNewsRankingModel()
        
        var array = [NewsDetailNewsRanking]()
        for (_, subjson) in json["newsRanking"] {
            let rankingModel = NewsDetailNewsRanking.parse(json: subjson)
            array.append(rankingModel)
        }
        model.newsRanking = array
        
        return model
    }
}

class NewsDetailNewsRanking: BaseModel {
    
    var title: String?
    var type: String?
    var list: Array<NewsDetailNewsRankingList>?
    
    class func parse(json: JSON) -> NewsDetailNewsRanking {
        let model = NewsDetailNewsRanking()
        model.title = json["title"].string
        model.type = json[""].string
        
        var array = [NewsDetailNewsRankingList]()
        for (_, subjson) in json["list"] {
            let listModel = NewsDetailNewsRankingList.parse(json: subjson)
            array.append(listModel)
        }
        model.list = array
        
        return model
    }
}

class NewsDetailNewsRankingList: BaseModel {
    
    var img: String?
    var title:String?
    var createTime: String?
    
    var commentNum: String?
    var discount: String?
    var price: String?
    
    var salePrice: String?
    var sales: String?
    var coupon: String?
    
    class func parse(json: JSON) -> NewsDetailNewsRankingList {
        let model = NewsDetailNewsRankingList()
        model.img = json["img"].string
        model.title = json["title"].string
        model.createTime = json["createTime"].string
        model.commentNum = json["commentNum"].string
        model.discount = json["discount"].string
        model.price = json["price"].string
        model.salePrice = json["salePrice"].string
        model.sales = json["sales"].string
        model.coupon = json["coupon"].string
        return model
    }
}
