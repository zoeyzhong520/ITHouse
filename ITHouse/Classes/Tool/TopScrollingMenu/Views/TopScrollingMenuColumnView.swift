//
//  TopScrollingMenuColumnView.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/26.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

@objc protocol TopScrollingMenuColumnViewDelegate: NSObjectProtocol {
    @objc optional
    func didSelectedItem(topScrollingMenuColumnView: TopScrollingMenuColumnView, selectedIndex: Int)
    
    @objc optional
    func updateColumnsSqlite(topScrollingMenuColumnView: TopScrollingMenuColumnView, updateResult: Bool, dataSource: [String])
}

class TopScrollingMenuColumnView: UIView {

    ///页面显示的闭包
    var showBlock: (() -> Void)?
    
    ///代理
    weak var delegate: TopScrollingMenuColumnViewDelegate?
    
    ///数据源（String数组）
    var dataSource = [String]()
    ///副数据源（String数组）
    var viceDataSource = [String]()
    ///能否编辑的数据源（Bool数组）
    fileprivate lazy var isCanEditDataSource: Array<Bool> = {
        var array = [Bool]()
        for _ in 0..<dataSource.count {
            array.append(false)
        }
        return array
    }()
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
        imageView.transform = CGAffineTransform.identity.rotated(by: CGFloat(Double.pi))
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
        let btn = UIButton(title: "编辑", titleColor: UIColor.mainColor, font: UIFont.navTitleFont, target: self, action: #selector(editClick(_:)))
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
        layout.headerReferenceSize = CGSize(width: self.bounds.size.width, height: ITHouseScale(50))
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClassOf(TopScrollingMenuColumnCell.self)
        collectionView.registerHeaderClassOf(TopScrollingMenuColumnHeader.self)
        
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
            make.top.equalTo((ITHouseScale(50-30))/2)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: ITHouseScale(30), height: ITHouseScale(30)))
        }
        
        editBtn.snp.makeConstraints { (make) in
            make.right.equalTo(coverView.snp.left).offset(-ITHouseScale(10))
            make.centerY.equalTo(coverView)
            make.size.equalTo(CGSize(width: ITHouseScale(60), height: ITHouseScale(25)))
        }
    }
}

extension TopScrollingMenuColumnView {
    
    @objc fileprivate func editClick(_ button: UIButton) {
        button.isSelected = !button.isSelected
        
        //编辑状态控制
        button.setTitle(button.isSelected ? "完成" : "编辑", for: .normal)
        sectionTitles = button.isSelected ? ["我的栏目（拖拽可以排序）","更多栏目（点击添加栏目）"] : ["我的栏目（点击进入栏目）","更多栏目（点击添加栏目）"]
        isCanEditDataSource.removeAll()
        for _ in 0..<dataSource.count {
            isCanEditDataSource.append(button.isSelected)
        }
        collectionView.reloadSections(IndexSet(integer: 0))
        
        if button.isSelected {
            addLongPress()
        } else {
            removeLongPress()
        }
    }
    
    ///添加长按手势
    fileprivate func addLongPress() {
        ///添加长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        longPress.minimumPressDuration = 0.3
        collectionView.addGestureRecognizer(longPress)
    }
    
    ///去除长按手势
    fileprivate func removeLongPress() {
        guard let gestures = collectionView.gestureRecognizers else {
            fatalError("collectionView获取gestureRecognizers失败")
        }
        for gesture in gestures {
            if gesture.isKind(of: UILongPressGestureRecognizer.classForCoder()) {
                collectionView.removeGestureRecognizer(gesture)
            }
        }
    }
    
    @objc fileprivate func coverViewClick(_ button: UIButton) {
        button.isSelected = !button.isSelected
        //旋转箭头图标
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseInOut, animations: {
            self.coverImageView.transform = CGAffineTransform.identity
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
    
    func show() {
        self.alpha = 0.0
        UIView.animate(withDuration: 0.25, delay: 0.1, options: .curveEaseInOut, animations: {
            (UIApplication.shared.delegate as! AppDelegate).window?.addSubview(self)
            self.contentView?.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
            self.alpha = 1.0
        }) { (finished) in
            self.configContentView()
            if self.showBlock != nil {
                self.showBlock!()
            }
        }
    }
    
    @objc fileprivate func hide() {
        self.alpha = 1.0
        UIView.animate(withDuration: 0.25, delay: 0.1, options: .curveEaseInOut, animations: {
            self.contentView?.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 0)
            self.collectionView.removeFromSuperview()
            self.updateColumnsSqlite()
            self.alpha = 0.0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    ///更新本地数据
    fileprivate func updateColumnsSqlite() {
        //更新本地columns数据
        TopScrollingMenuTool.updateColumnsSqlite(dataSource: dataSource, viceDataSource: viceDataSource) { [weak self] (result) in
            if self?.delegate != nil {//代理
                self?.delegate?.updateColumnsSqlite!(topScrollingMenuColumnView: self!, updateResult: result, dataSource: self!.dataSource)
            }
        }
    }
}

extension TopScrollingMenuColumnView {
    
    ///开始拖拽
    fileprivate func dragBeigin(gesture: UILongPressGestureRecognizer) {
        let point = gesture.location(in: collectionView)
        dragingIndexPath = TopScrollingMenuTool.getDragingIndexPath(point: point, forCollectionView: collectionView)
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
        targetIndexPath = TopScrollingMenuTool.getTargetIndexPath(point: point, forCollectionView: collectionView, ofDragingIndexPath: dragingIndexPath)
        DLog(targetIndexPath)
        if dragingIndexPath != nil && targetIndexPath != nil {
            collectionView.moveItem(at: dragingIndexPath!, to: targetIndexPath!)
            
            //交换数据源中数据的对应位置
            let dragingTitle = dataSource[dragingIndexPath!.row]
            let targetTitle = dataSource[targetIndexPath!.row]
            dataSource.remove(at: dragingIndexPath!.row)
            dataSource.remove(at: targetIndexPath!.row)
            dataSource.insert(dragingTitle, at: targetIndexPath!.row)
            dataSource.insert(targetTitle, at: dragingIndexPath!.row)
            
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
        let cell:TopScrollingMenuColumnCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.titleText = indexPath.section == 0 ? dataSource[indexPath.row] : viceDataSource[indexPath.row]
        cell.isCanDelete = indexPath.section == 0 ? isCanEditDataSource[indexPath.row] : false
        cell.deleteBlock = { [weak self] in
            self?.cellDeleteClick(indexPath: indexPath)
        }
        return cell
    }
    
    ///cell点击删除按钮
    fileprivate func cellDeleteClick(indexPath: IndexPath) {
        let obj = dataSource[indexPath.row]
        viceDataSource.append(obj)
        dataSource.remove(at: indexPath.row)
        isCanEditDataSource.remove(at: indexPath.row)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil && indexPath.section == 0 {
            delegate?.didSelectedItem!(topScrollingMenuColumnView: self, selectedIndex: indexPath.row)
            hide()
        }
        
        if indexPath.section == 1 {//处理两个栏目间的数据交换
            let obj = viceDataSource[indexPath.row]
            dataSource.append(obj)
            viceDataSource.remove(at: indexPath.row)
            isCanEditDataSource.append(false)
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header:TopScrollingMenuColumnHeader = collectionView.dequeuereusableSupplymentaryView(ofKind: UICollectionView.elementKindSectionHeader, forIndexPath: indexPath)
            header.titleText = sectionTitles[indexPath.section]
            return header
        }
        return UICollectionReusableView()
    }
}
