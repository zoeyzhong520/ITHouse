//
//  ProfileModel.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/3/7.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ProfileModel: NSObject {

    @objc var img: String?
    @objc var title: String?
    @objc var content: String?
    
    class func getArray() -> [[ProfileModel]] {
        
        let array = [
            [
                ["img":"","title":"金币商城","content":""],
                ["img":"","title":"金币任务","content":""]
            ],
            [
                ["img":"","title":"我的消息","content":""],
                ["img":"","title":"我的资产","content":""]
            ],
            [
                ["img":"","title":"设置","content":""],
                ["img":"","title":"推荐给好友","content":""],
                ["img":"","title":"关于","content":"v\(appVersion!)"]
            ]
        ]
        
        let modelsArray = mj_objectArray(withKeyValuesArray: array)
        return modelsArray as! [[ProfileModel]]
        
    }
    
}
