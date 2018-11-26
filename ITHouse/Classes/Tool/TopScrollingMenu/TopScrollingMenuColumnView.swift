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
        btn.layer.cornerRadius = ITHouseScale(15)
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
        backgroundColor = .white
        
        if contentView == nil {
            contentView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: ITHouseScale(50)))
            contentView?.backgroundColor = UIColor.lightGray
            addSubview(contentView!)
            
//            contentView?.addSubview(collectionView)
            contentView?.addSubview(editBtn)
            contentView?.addSubview(coverView)
            
            coverView.snp.makeConstraints { (make) in
                make.right.top.equalToSuperview()
                make.size.equalTo(CGSize(width: ITHouseScale(30), height: ITHouseScale(30)))
            }
            
            editBtn.snp.makeConstraints { (make) in
                make.right.equalTo(coverView.snp.left)
                make.centerY.equalTo(coverView)
                make.size.equalTo(CGSize(width: ITHouseScale(55), height: ITHouseScale(30)))
            }
        }
    }
    
    //MARK: - Show && Hide
    func show() {
        
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
            (UIApplication.shared.delegate as! AppDelegate).window?.addSubview(self)
            
        }) { (finished) in
            
        }
    }
    
    @objc fileprivate func hide() {
        
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
            
        }) { (finished) in
            self.removeFromSuperview()
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
        label.layer.masksToBounds = true
        label.layer.cornerRadius = ITHouseScale(15)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.grayTextColor.cgColor
        cell.contentView.addSubview(label)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hide()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeuereusableSupplymentaryView(ofKind: UICollectionView.elementKindSectionHeader, forIndexPath: indexPath)
            let label = UILabel(title: sectionTitles[indexPath.section], titleFont: UIFont.titleFont, titleColor: UIColor.blackTextColor, alignment: .left)
            header.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            return header
        }
        return UICollectionReusableView()
    }
}
