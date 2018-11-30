//
//  NewsBanner.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsBannerModel: BaseModel {

    var images: Array<String>?
    
    class func parseDict(dict: [String: Any]) -> NewsBannerModel {
        let json = JSON(dict)
        let model = NewsBannerModel()
        
        var array = [String]()
        for (_, subjson) in json["images"] {
            if subjson.string != nil {
                array.append(subjson.string!)
            }
        }
        model.images = array
        return model
    }
}
