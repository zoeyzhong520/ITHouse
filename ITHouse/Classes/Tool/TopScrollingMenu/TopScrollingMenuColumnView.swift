//
//  TopScrollingMenuColumnView.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/26.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class TopScrollingMenuColumnView: UIView {

    ///数据源（String数组）
    var dataSource = [String]()
    ///副数据源（String数组）
    var viceDataSource = [String]()
    ///分组标题数组
    fileprivate var sectionTitles = ["我的栏目（点击进入栏目）","更多栏目（点击添加栏目）"]
    ///contentView
    fileprivate var contentView: UIView?
    ///拖拽的Cel
    fileprivate var dragingCell:UICollectionViewCell!
    ///拖拽cell的IndexPath
    fileprivate var dragingIndexPath: IndexPath?
    ///目标cell的IndexPath
    fileprivate var targetIndexPath: IndexPath?
    
    ///最右端的箭头view
    fileprivate lazy var coverView: UIButton = {
        let view = UIButton()
        view.isSelected = true
        view.addTarget(self, action: #selector(coverViewClick(_:)), for: .touchUpInside)
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "downArrowImg"))
        view.addSubview(imageView)
        coverImageView = imageView
        imageView.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 18, height: 18))
        })
        return view
    }()
    ///箭头ImageView
    fileprivate var coverImageView: UIImageView!
    
    ///编辑按钮
    fileprivate lazy var editBtn: UIButton = {
        let btn = UIButton(title: "编辑", titleColor: UIColor.mainColor, font: UIFont.navTitleFont, target: self, action: #selector(editClick))
        btn.layer.masksToBounds = true
        btn.layer.borderColor = UIColor.mainColor.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = ITHouseScale(25/2)
        return btn
    }()
    
    ///collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let marigin = ITHouseScale(15)
        layout.itemSize = CGSize(width: ITHouseScale(75), height: ITHouseScale(30))
        layout.sectionInset = UIEdgeInsets(top: 0, left: marigin, bottom: marigin, right: marigin)
        layout.minimumLineSpacing = marigin
        layout.minimumInteritemSpacing = marigin
        layout.headerReferenceSize = CGSize(width: self.bounds.size.width, height: ITHouseScale(30))
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClassOf(UICollectionViewCell.self)
        collectionView.registerHeaderClassOf(UICollectionReusableView.self)
        
        ///添加长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        longPress.minimumPressDuration = 0.3
        collectionView.addGestureRecognizer(longPress)
        
        dragingCell = UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: ITHouseScale(75), height: ITHouseScale(75/2)))
        dragingCell.isHidden = true
        collectionView.addSubview(dragingCell)
        
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
        frame = CGRect(x: 0, y: STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT, width: SCREEN_WIDTH, height: CONTENT_HEIGHT)
        
        if contentView == nil {
            contentView = UIView()
            contentView?.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 0)
            contentView?.backgroundColor = UIColor.white
            addSubview(contentView!)
        }
    }
    
    ///Config ContentView
    fileprivate func configContentView() {
        contentView?.addSubview(collectionView)
        contentView?.addSubview(editBtn)
        contentView?.addSubview(coverView)
        
        coverView.snp.makeConstraints { (make) in
            make.right.top.equalToSuperview()
            make.size.equalTo(CGSize(width: ITHouseScale(30), height: ITHouseScale(30)))
        }
        
        editBtn.snp.makeConstraints { (make) in
            make.right.equalTo(coverView.snp.left).offset(-ITHouseScale(10))
            make.centerY.equalTo(coverView)
            make.size.equalTo(CGSize(width: ITHouseScale(60), height: ITHouseScale(25)))
        }
    }
    
    @objc fileprivate func editClick() {
        
    }
    
    @objc fileprivate func coverViewClick(_ button: UIButton) {
        button.isSelected = !button.isSelected
        //旋转箭头图标
        self.coverImageView.transform = !button.isSelected ? CGAffineTransform.identity : CGAffineTransform.identity.rotated(by: -CGFloat(Double.pi))
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseInOut, animations: {
            self.coverImageView.transform = !button.isSelected ? CGAffineTransform.identity.rotated(by: -CGFloat(Double.pi)) : CGAffineTransform.identity
        }) { (finished) in
            self.hide()
        }
    }
    
    @objc fileprivate func longPress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            dragBeigin(gesture: gesture)
        case .changed:
            dragChanged(gesture: gesture)
        case .ended:
            dragEnded(gesture: gesture)
        default:
            break
        }
    }
}

extension TopScrollingMenuColumnView {
    
    //MARK: - Show && Hide
    func show() {
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
            (UIApplication.shared.delegate as! AppDelegate).window?.addSubview(self)
            self.contentView?.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        }) { (finished) in
            self.configContentView()
        }
    }
    
    @objc fileprivate func hide() {
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
            self.contentView?.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 0)
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
}

extension TopScrollingMenuColumnView {
    
    ///获取被拖动IndexPath的方法
    fileprivate func getDragingIndexPath(point: CGPoint) -> IndexPath? {
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
        return dragingIndexPath
    }
    
    ///获取目标IndexPath的方法
    fileprivate func getTargetIndexPath(point: CGPoint) -> IndexPath? {
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
        return targetIndexPath
    }
    
    ///开始拖拽
    fileprivate func dragBeigin(gesture: UILongPressGestureRecognizer) {
        let point = gesture.location(in: collectionView)
        dragingIndexPath = getDragingIndexPath(point: point)
        if dragingIndexPath == nil {
            return
        }
        DLog("拖拽开始: \(dragingIndexPath!)")
        guard let cell = collectionView.cellForItem(at: dragingIndexPath!) else {
            fatalError("collectionView获取cell失败")
        }
        dragingCell.frame = cell.frame
        dragingCell.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.dragingCell.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
        }
    }
    
    ///拖拽中
    fileprivate func dragChanged(gesture: UILongPressGestureRecognizer) {
        DLog("拖拽中")
        let point = gesture.location(in: collectionView)
        dragingCell.center = point
        targetIndexPath = getTargetIndexPath(point: point)
        DLog(targetIndexPath)
        if dragingIndexPath != nil && targetIndexPath != nil {
            collectionView.moveItem(at: dragingIndexPath!, to: targetIndexPath!)
            dragingIndexPath = targetIndexPath
        }
    }
    
    ///拖拽结束
    fileprivate func dragEnded(gesture: UILongPressGestureRecognizer) {
        DLog("拖拽结束")
        if dragingIndexPath == nil {
            return
        }
        guard let endFrame = collectionView.cellForItem(at: dragingIndexPath!)?.frame else {
            fatalError("collectionView获取cell的frame失败")
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.dragingCell.transform = CGAffineTransform.identity
            self.dragingCell.frame = endFrame
        }) { (finished) in
            self.dragingCell.isHidden = true
        }
    }
}

extension TopScrollingMenuColumnView:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? dataSource.count : viceDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let label = UILabel(title: indexPath.section == 0 ? dataSource[indexPath.row] : viceDataSource[indexPath.row], titleFont: UIFont.titleFont, titleColor: UIColor.blackTextColor, alignment: .center)
        cell.contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = ITHouseScale(15)
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.grayTextColor.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        hide()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeuereusableSupplymentaryView(ofKind: UICollectionView.elementKindSectionHeader, forIndexPath: indexPath)
            let label = UILabel(title: sectionTitles[indexPath.section], titleFont: UIFont.navTitleFont, titleColor: UIColor.black, alignment: .left)
            header.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsets(top: 0, left: ITHouseScale(15), bottom: 0, right: 0))
            }
            return header
        }
        return UICollectionReusableView()
    }
}
