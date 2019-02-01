//
//  ShareToolCollectionView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/7.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

@objc protocol ShareToolCollectionViewDelegate: NSObjectProtocol {
    @objc optional
    func didSelectItem(withModel model: ShareToolModel?)
}

///分享工具集合视图
class ShareToolCollectionView: UIView {

    weak var delegate: ShareToolCollectionViewDelegate?
    
    ///数据源
    var dataArr: NSArray? {
        didSet {
            if let tmpDataArr = dataArr {
                dataArr = ShareToolModel.mj_objectArray(withKeyValuesArray: tmpDataArr)
                collectionView.reloadData()
            }
        }
    }
    
    ///collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ITHouseScale(80), height: ITHouseScale(70))
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: ITHouseScale(10), left: ITHouseScale(10), bottom: ITHouseScale(10), right: ITHouseScale(10))
        layout.minimumLineSpacing = ITHouseScale(10)
        
        let view = UICollectionView(frame: bounds, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.registerClassOf(ShareToolCollectionViewCell.self)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addViews() {
        addSubview(collectionView)
    }
}

extension ShareToolCollectionView: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ShareToolCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let tmpArr = dataArr as? [ShareToolModel]
        cell.model = tmpArr?[indexPath.row]
        cell.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCell(_:))))
        cell.contentView.tag = indexPath.row
        return cell
    }
}

extension ShareToolCollectionView {
    
    //MARK: - function
    @objc fileprivate func tapCell(_ tap: UITapGestureRecognizer) {
        guard let tag = tap.view?.tag else {
            fatalError("获取tag失败！")
        }
        let tmpArr = dataArr as? [ShareToolModel]
        if delegate != nil {
            delegate?.didSelectItem!(withModel: tmpArr?[tag])
        }
    }
}
