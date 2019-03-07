//
//  CircleHeaderView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/2/25.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class CircleHeaderView: UIView {

    ///模型
    var model: CircleModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    ///collectionViewHeight
    fileprivate let collectionViewHeight = ITHouseScale(100)
    
    ///baseTitlesViewHeight
    fileprivate let baseTitlesViewHeight = ITHouseScale(40)
    
    ///collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionViewHeight-ITHouseScale(30), height: collectionViewHeight)
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: collectionViewHeight), collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.clear
        view.registerClassOf(CircleHeaderCollectionCell.self)
        return view
    }()
    
    ///分割线
    fileprivate lazy var lineView: UIView = {
        let line = UIView(frame: CGRect(x: 0, y: collectionView.frame.maxY, width: SCREEN_WIDTH, height: ITHouseScale(10)))
        line.backgroundColor = UIColor.lightGrayColor
        return line
    }()
    
    ///baseTitlesView
    lazy var baseTitlesView: BaseTitlesViewTool = {
        let view = BaseTitlesViewTool(frame: CGRect(x: 0, y: lineView.frame.maxY, width: SCREEN_WIDTH, height: baseTitlesViewHeight), buttonNameArray: ["新回复","热帖","新发表","精华"])
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
        addSubview(lineView)
        addSubview(baseTitlesView)
    }
}

extension CircleHeaderView: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.publishType?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CircleHeaderCollectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configCell(title: model?.publishType?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
