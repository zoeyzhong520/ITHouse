//
//  TopScrollingMenuTool.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/28.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class TopScrollingMenuTool: NSObject {

    ///获取被拖动IndexPath的方法
    static func getDragingIndexPath(point: CGPoint, forCollectionView collectionView: UICollectionView) -> IndexPath? {
        var dragingIndexPath: IndexPath?
        for indexPath in collectionView.indexPathsForVisibleItems {
            guard let cell = collectionView.cellForItem(at: indexPath) else {
                fatalError("collectionView获取cell失败")
            }
            if cell.frame.contains(point) {
                dragingIndexPath = indexPath
                break
            }
        }
        return dragingIndexPath?.section != 0 ? nil : dragingIndexPath
    }
    
    ///获取目标IndexPath的方法
    static func getTargetIndexPath(point: CGPoint, forCollectionView collectionView: UICollectionView, ofDragingIndexPath dragingIndexPath: IndexPath?) -> IndexPath? {
        var targetIndexPath: IndexPath?
        for indexPath in collectionView.indexPathsForVisibleItems {
            guard let cell = collectionView.cellForItem(at: indexPath) else {
                fatalError("collectionView获取cell失败")
            }
            //避免和当前拖拽的cell重复
            if indexPath == dragingIndexPath {
                continue
            }
            //判断是否包含这个点
            if cell.frame.contains(point) {
                targetIndexPath = indexPath
            }
        }
        return targetIndexPath?.section != 0 ? nil : targetIndexPath
    }
    
    static func updateColumnsSqlite(dataSource: [String], viceDataSource: [String], resultBlock: @escaping (Bool) -> Void) {
        
        var columns = [String]()
        var moreColumns = [String]()
        
        ITHouseHttpTool.newsColumnsData { (model) in
            for (_, column) in (model.columns?.enumerated())! {
                if column.name != nil {
                    columns.append(column.name!)
                }
            }
            
            for (_, moreColum) in (model.moreColumns?.enumerated())! {
                if moreColum.name != nil {
                    moreColumns.append(moreColum.name!)
                }
            }
            
            if columns == dataSource && moreColumns == viceDataSource {//判断未更改栏目不更新数据
                return
            } else {
                //保存滚动菜单数据到本地
                var columnsArr = [[String: Any]]()
                var moreColumnsArr = [[String: Any]]()
                let itemDict = NSMutableDictionary()
                
                for (_, title) in dataSource.enumerated() {
                    columnsArr.append(["name": title])
                }
                
                for (_, viceTitle) in viceDataSource.enumerated() {
                    moreColumnsArr.append(["name": viceTitle])
                }
                
                itemDict.setObject(columnsArr, forKey: "columns" as NSCopying)
                itemDict.setObject(moreColumnsArr, forKey: "moreColumns" as NSCopying)
                
                //更新本地数据
                ITHouseHttpTool.updateItem(item: itemDict, withCacheKey: String.newsColumnsFileName) { (result) in
                    resultBlock(result)
                }
            }
        }
    }
}
