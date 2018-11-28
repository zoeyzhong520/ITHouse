//
//  TopScrollingMenuColumnCell.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/28.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class TopScrollingMenuColumnCell: UICollectionViewCell {
    
    ///删除闭包
    var deleteBlock: (() -> Void)?
    
    ///数据源
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    ///是否删除
    var isCanDelete: Bool? {
        didSet {
            deleteBtn.isHidden = isCanDelete == false
        }
    }
    
    ///标题label
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.blackTextColor, alignment: .center)
        return label
    }()
    
    ///删除按钮
    fileprivate lazy var deleteBtn: UIButton = {
        let btn = UIButton(title: "X", titleColor: UIColor.white, font: UIFont.titleFont, target: self, action: #selector(deleteClick))
        btn.backgroundColor = UIColor.grayTextColor
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = ITHouseScale(12)
        btn.isHidden = true
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///UI
    fileprivate func addViews() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = ITHouseScale(15)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.grayTextColor.cgColor
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        deleteBtn.snp.makeConstraints { (make) in
            make.centerY.right.equalToSuperview()
            make.size.equalTo(CGSize(width: ITHouseScale(24), height: ITHouseScale(24)))
        }
    }
    
    @objc fileprivate func deleteClick() {
        if deleteBlock != nil {
            deleteBlock!()
        }
    }
}
