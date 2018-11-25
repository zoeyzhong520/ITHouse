//
//  TopScrollingMenuSegmentView.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/25.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class TopScrollingMenuSegmentView: UIView {

    ///数据源
    var dataSource = [String]()
    ///存储item宽度数组
    var itemWidths = [CGFloat]()
    ///存储选中indexPath的字典
    fileprivate var indexPathsDict = NSMutableDictionary()
    ///CollectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.registerClassOf(TopScrollingMenuSegmentCell.self)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///UI
    fileprivate func createUI() {
        addSubview(collectionView)
        //默认选中第一个item
        indexPathsDict.setObject(true, forKey: "\(0)" as NSCopying)
    }
}

extension TopScrollingMenuSegmentView:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:TopScrollingMenuSegmentCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.text = dataSource[indexPath.row]
        cell.isItemSelected = indexPathsDict.object(forKey: "\(indexPath.row)") as? Bool
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexPathsDict.setObject(true, forKey: "\(indexPath.row)" as NSCopying)
        for key in indexPathsDict.allKeys {
            //判断字典中key是否存在，并更新字典
            let t_key = key as! String
            if t_key != "\(indexPath.row)" {
                indexPathsDict.setObject(false, forKey: t_key as NSCopying)
            }
        }
        //设置点击item滚动
        if indexPath.row < dataSource.count - 1 {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        //刷新
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemWidths[indexPath.row], height: bounds.size.height)
    }
}
