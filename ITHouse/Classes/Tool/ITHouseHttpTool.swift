//
//  ITHouseHttpTool.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/28.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class ITHouseHttpTool: NSObject {

    ///更新本地数据
    static func updateItem(item: Any, withCacheKey cacheKey: String, resultBlock: @escaping (Bool) -> Void) {
        DBManager.shared().updateItem(item, cacheKey: cacheKey) { (result) in
            resultBlock(result)
        }
    }
    
    ///根据文件名获取JSON数据
    static func jsonWithFileName(fileName: String) -> [String: Any] {
        
        if fileName == "" {
            fatalError("JSON文件名不能为空")
        }
        
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        let data = NSData(contentsOfFile: path!)! as Data
        let dict = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        DLog("jsonFile: \(fileName) dict: \(dict)")
        return dict as! [String: Any]
    }
    
    //MARK: - 资讯API
    
    ///资讯-栏目
    static func newsColumnsData(successBlock: (NewsColumnsModel) -> Void) {
        
        let obj = DBManager.shared().item(withCacheKey: String.newsColumnsFileName) as? [String: Any]
        if obj != nil {
            let model = NewsColumnsModel.parseDict(dict: obj!)
            successBlock(model)
            return
        }
        
        let dict = ITHouseHttpTool.jsonWithFileName(fileName: String.newsColumnsFileName)
        //写入数据库
        DBManager.shared().insertItem(dict, cacheKey: String.newsColumnsFileName)
        
        let model = NewsColumnsModel.parseDict(dict: dict)
        successBlock(model)
    }
    
    ///资讯-banner
    static func newsBannerData(successBlock: (NewsBannerModel) -> Void) {
        
        let obj = DBManager.shared().item(withCacheKey: String.newsBannerFileName) as? [String: Any]
        if obj != nil {
            let model = NewsBannerModel.parseDict(dict: obj!)
            successBlock(model)
            return
        }
        
        let dict = ITHouseHttpTool.jsonWithFileName(fileName: String.newsBannerFileName)
        DBManager.shared().insertItem(dict, cacheKey: String.newsBannerFileName)
        
        let model = NewsBannerModel.parseDict(dict: dict)
        successBlock(model)
    }
    
    ///资讯-news
    static func newsNewsData(successBlock: (NewsDetailNewsModel) -> Void) {
        
        let obj = DBManager.shared().item(withCacheKey: String.newsNewsFileName) as? [String: Any]
        if obj != nil {//直接把数据库的数据进行回调
            let model = NewsDetailNewsModel.parseDict(dict: obj!)
            successBlock(model)
            return
        }
        
        let dict = ITHouseHttpTool.jsonWithFileName(fileName: String.newsNewsFileName)
        DBManager.shared().insertItem(dict, cacheKey: String.newsNewsFileName)
        
        let model = NewsDetailNewsModel.parseDict(dict: dict)
        successBlock(model)
    }
    
    ///资讯-newsRanking
    static func newsRankingData(successBlock: (NewsDetailNewsRankingModel) -> Void) {
        
        let obj = DBManager.shared().item(withCacheKey: String.newsRankingFileName) as? [String: Any]
        if obj != nil {//直接把数据库的数据进行回调
            let model = NewsDetailNewsRankingModel.parseDict(dict: obj!)
            successBlock(model)
            return
        }
        
        let dict = ITHouseHttpTool.jsonWithFileName(fileName: String.newsRankingFileName)
        DBManager.shared().insertItem(dict, cacheKey: String.newsRankingFileName)
        
        let model = NewsDetailNewsRankingModel.parseDict(dict: dict)
        successBlock(model)
    }
    
    ///资讯-newsPhotoText
    static func newsPhotoTextData(successBlock: (NewsDetailNewsPhotoTextModel) -> Void) {
        
        let obj = DBManager.shared().item(withCacheKey: String.newsPhotoTextFileName) as? [String: Any]
        if obj != nil {//直接把数据库的数据进行回调
            let model = NewsDetailNewsPhotoTextModel.parseDict(dict: obj!)
            model.newsPhotoTextRowHeight()
            successBlock(model)
            return
        }
        
        let dict = ITHouseHttpTool.jsonWithFileName(fileName: String.newsPhotoTextFileName)
        DBManager.shared().insertItem(dict, cacheKey: String.newsPhotoTextFileName)
        
        let model = NewsDetailNewsPhotoTextModel.parseDict(dict: dict)
        model.newsPhotoTextRowHeight()
        successBlock(model)
    }
    
    ///资讯-newsHotReview
    static func newsHotReviewData(successBlock: (NewsDetailHotReviewModel) -> Void) {
        let obj = DBManager.shared().item(withCacheKey: String.newsHotReviewFileName) as? [String: Any]
        if obj != nil {
            let model = NewsDetailHotReviewModel.parseDict(dict: obj!)
            model.newsHotReviewRowHeight()
            successBlock(model)
            return
        }
        
        let dict = ITHouseHttpTool.jsonWithFileName(fileName: String.newsHotReviewFileName)
        DBManager.shared().insertItem(dict, cacheKey: String.newsHotReviewFileName)
        
        let model = NewsDetailHotReviewModel.parseDict(dict: dict)
        model.newsHotReviewRowHeight()
        successBlock(model)
    }
}
