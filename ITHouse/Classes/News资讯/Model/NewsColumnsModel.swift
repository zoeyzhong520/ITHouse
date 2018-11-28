//
//  NewsColumnsModel.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/28.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class NewsColumnsModel: BaseModel {

    var columns: Array<NewsColumn>?
    var moreColumns: Array<NewsColumn>?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return [
            "columns": "NewsColumn",
            "moreColumns": "NewsColumn"
        ]
    }
}

class NewsColumn: BaseModel {
    
    var name: String?
    var ID: String?
    
}


