//
//  CircleModel.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/2/14.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit
import SwiftyJSON

class CircleModel: NSObject {

    var publishType: [String]?
    var publishTypeDescription: [[String]]?
    var circleList: Array<CircleListModel>?
    
    class func initModel(dict: [String: Any]) -> CircleModel {
        
        let model = CircleModel()
        
        guard let publishType = dict["publishType"] as? [String], let publishTypeDescription = dict["publishTypeDescription"] as? [[String]] else { return CircleModel() }
        model.publishType = publishType
        model.publishTypeDescription = publishTypeDescription
        
        return model
        
    }
    
    class func parseDict(dict: [String: Any]) -> CircleModel {
        
        let json = JSON(dict)
        
        let model = CircleModel()
        
        var array = [CircleListModel]()
        for (_, subjson) in json["circleList"] {
            let item = CircleListModel.parse(json: subjson)
            array.append(item)
        }
        model.circleList = array
        
        return model
        
    }
    
}

class CircleListModel: NSObject {
    
    var img: String?
    var nickName: String?
    var title: String?
    
    var type: String?
    var comment: String?
    var createTime: String?
    
    class func parse(json: JSON) -> CircleListModel {
        
        let model = CircleListModel()
        model.img = json["img"].string
        model.nickName = json["nickName"].string
        model.title = json["title"].string
        
        model.type = json["type"].string
        model.comment = json["comment"].string
        model.createTime = json["createTime"].string
        return model
        
    }
    
}
