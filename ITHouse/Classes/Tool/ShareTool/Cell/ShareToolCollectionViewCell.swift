//
//  ShareToolCollectionViewCell.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/7.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ShareToolCollectionViewCell: UICollectionViewCell {
    
    ///数据模型
    var model: ShareToolModel? {
        didSet {
            imgView.image = UIImage(named: model?.img ?? "")
            titleLabel.text = model?.title
        }
    }
    
    ///图片
    fileprivate lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.lightGrayColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ITHouseScale(50)/2
        return view
    }()
    
    ///标题
    fileprivate lazy var titleLabel: UILabel = {
        let view = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.blackTextColor, alignment: .center)
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
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        imgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: ITHouseScale(50), height: ITHouseScale(50)))
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(ITHouseScale(13))
        }
    }
}
