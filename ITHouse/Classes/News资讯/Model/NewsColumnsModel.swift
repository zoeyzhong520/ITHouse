//
//  NewsColumnsModel.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/28.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsColumnsModel: BaseModel {

    var columns: Array<NewsColumn>?
    var moreColumns: Array<NewsColumn>?
    
    class func parseDict(dict: [String : Any]) -> NewsColumnsModel {
        
        let json = JSON(dict)
        let model = NewsColumnsModel()
        
        var columnsArr = [NewsColumn]()
        for (_, subjson) in json["columns"] {
            let columnModel = NewsColumn.parse(json: subjson)
            columnsArr.append(columnModel)
        }
        model.columns = columnsArr
        
        var moreColumnsArr = [NewsColumn]()
        for (_, subjson) in json["moreColumns"] {
            let moreColumnModel = NewsColumn.parse(json: subjson)
            moreColumnsArr.append(moreColumnModel)
        }
        model.moreColumns = moreColumnsArr
        
        return model
    }
}

class NewsColumn: BaseModel {
    
    var name: String?
    var ID: String?
    
    class func parse(json: JSON) -> NewsColumn {
        let model = NewsColumn()
        model.name = json["name"].string
        model.ID = json["ID"].string
        return model
    }
}


