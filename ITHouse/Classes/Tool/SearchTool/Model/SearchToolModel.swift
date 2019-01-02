//
//  SearchToolModel.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/12/29.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchToolModel: BaseModel {

    var hot: Array<String>?
    var history: Array<String>?
    var hotRowHeight: CGFloat?
    
    class func parseDict(dict: [String: Any]) -> SearchToolModel {
        let json = JSON(dict)
        let model = SearchToolModel()
        
        var hotArr = [String]()
        for (_, subjson) in json["hot"] {
            if subjson.string != nil {
                hotArr.append(subjson.string!)
            }
        }
        model.hot = hotArr
        
        var historyArr = [String]()
        for (_, subjson) in json["history"] {
            if subjson.string != nil {
                historyArr.append(subjson.string!)
            }
        }
        model.history = historyArr
        return model
    }
    
    ///计算热门搜索cell的行高
    func calculateHotRowHeight() {
        guard let array = self.hot else {
            fatalError("the hot array is nil")
        }
        
        self.hotRowHeight = CGFloat(array.count > 0 ? array.count/5 : 1)*(ITHouseScale(10)+ITHouseScale(30))+ITHouseScale(10)
    }
}

class SearchResultModel: BaseModel {
    
    var result: Array<SearchResultListModel>?
    
    class func parseDict(dict: [String: Any]) -> SearchResultModel {
        let json = JSON(dict)
        let model = SearchResultModel()
        
        var resultArr = [SearchResultListModel]()
        for (_, subjson) in json["result"] {
            let list = SearchResultListModel.parse(json: subjson)
            resultArr.append(list)
        }
        model.result = resultArr
        return model
    }
    
}

class SearchResultListModel: BaseModel {
    
    var title: String?
    var createTime: String?
    
    class func parse(json: JSON) -> SearchResultListModel {
        let model = SearchResultListModel()
        model.title = json["title"].string
        model.createTime = json["createTime"].string
        return model
    }
    
}
