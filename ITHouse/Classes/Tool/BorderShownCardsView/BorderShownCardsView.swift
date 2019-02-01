//
//  BorderShownCardsView.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class BorderShownCardsView: UIView {

    ///数据源（图片链接数组）
    var images: Array<String>? {
        didSet {
            collectionView.reloadData()
            createTimer()
        }
    }
    ///滚动间隔（默认5s）
    var rollingInterval: TimeInterval = 5.0
    ///计时器timer
    fileprivate var timer: Timer?
    ///ItemMargin
    fileprivate let itemMargin = ITHouseScale(7)
    ///HorizontalMargin
    fileprivate let horizontalMargin = ITHouseScale(15)
    ///cellID
    fileprivate let cellID = "cellID"
    ///当前滚动的位置
    private(set) var currentIndex = 0
    
    ///collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = bounds.size.width - horizontalMargin*2
        layout.itemSize = CGSize(width: itemWidth, height: bounds.size.height)
        layout.minimumLineSpacing = itemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: horizontalMargin, bottom: 0, right: horizontalMargin)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.clipsToBounds = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.register(BorderShownCardsCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.addGestureRecognizer(panScrollView.panGestureRecognizer)
        collectionView.panGestureRecognizer.isEnabled = false
        
        return collectionView
    }()
    
    ///panScrollView
    fileprivate lazy var panScrollView: UIScrollView = {
        let panScrollViewWidth = itemMargin + (bounds.size.width - horizontalMargin*2)
        let panScrollView = UIScrollView(frame: CGRect(x: (bounds.size.width - panScrollViewWidth)/2, y: 0, width: panScrollViewWidth, height: bounds.size.height))
        panScrollView.isHidden = true
        panScrollView.isPagingEnabled = true
        panScrollView.alwaysBounceHorizontal = true
        panScrollView.delegate = self
        panScrollView.contentOffset = CGPoint(x: 0, y: 0)
        return panScrollView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    ///UI
    fileprivate func addViews() {
        addSubview(collectionView)
        addSubview(panScrollView)
        DLog("滚动到第\(currentIndex)张")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///设定计时器
    func createTimer() {
        if timer?.isValid == true {
            releaseTimer()
        }
        
        timer = Timer(timeInterval: rollingInterval, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    ///释放计时器
    func releaseTimer() {
        guard let tmpTimer = timer else {
            fatalError("timer is nil")
        }
        tmpTimer.invalidate()
        timer = nil
    }
    
    ///设置滚动
    @objc fileprivate func autoScroll() {
        guard let images = images else {
            return
        }
        
        //滚到最后一页的时候，回到第一页
        
        if panScrollView.contentOffset.x >= panScrollView.frame.size.width * CGFloat(images.count-2) {
            panScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        } else {
            panScrollView.setContentOffset(CGPoint(x: panScrollView.contentOffset.x + panScrollView.frame.size.width, y: 0), animated: true)
        }
        
        //获取当前索引
        currentIndex = Int(panScrollView.contentOffset.x)/Int(panScrollView.frame.size.width)+1
        if currentIndex == images.count {
            currentIndex = 0
        }
        DLog("滚动到第\(currentIndex)张")
    }
}

extension BorderShownCardsView:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        panScrollView.contentSize = CGSize(width: panScrollView.frame.size.width*CGFloat(images?.count ?? 0), height: 0)
        
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? BorderShownCardsCell else {
            fatalError("dequeueReusableCell with \(cellID) failed")
        }
        cell.imageUrl = images?[indexPath.row]
        return cell
    }
}

extension BorderShownCardsView:UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == panScrollView {
            collectionView.contentOffset = panScrollView.contentOffset
        }
    }
}
