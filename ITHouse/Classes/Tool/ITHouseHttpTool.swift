//
//  ITHouseHttpTool.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/28.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class ITHouseHttpTool: NSObject {

    ///根据文件名获取JSON数据
    static func jsonWithFileName(fileName: String) -> [String: Any] {
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        let data = NSData(contentsOfFile: path!)! as Data
        let dict = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        DLog("jsonFile: \(fileName) dict: \(dict)")
        return dict as! [String: Any]
    }
    
    ///资讯-栏目数据
    static func newsColumnsData(successBlock: ((NewsColumnsModel?) -> Void)?) {
        let dict = ITHouseHttpTool.jsonWithFileName(fileName: String.newsColumnsFileName)
        let model = NewsColumnsModel.mj_object(withKeyValues: dict)
        
        //写入数据库
        DBManager.shared().insertItem(dict, cacheKey: String.newsColumnsFileName)
        
        if successBlock != nil {
            successBlock!(model)
        }
    }
}
