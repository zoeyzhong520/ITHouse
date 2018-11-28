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
}
