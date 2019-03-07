//
//  CircleHeaderCollectionCell.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/3/7.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class CircleHeaderCollectionCell: UICollectionViewCell {
    
    ///图片
    fileprivate lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = RandomColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ITHouseScale(20)
        return view
    }()
    
    ///标题
    fileprivate lazy var titleLabel: UILabel = {
        let lb = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.blackTextColor, alignment: .center)
        return lb
    }()
    
    ///副标题
    fileprivate lazy var subTitleLabel: UILabel = {
        let lb = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.mainColor, alignment: .center)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - function
    fileprivate func addViews() {
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
    }
    
    override func layoutSubviews() {
        imgView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(ITHouseScale(10))
            make.size.equalTo(CGSize(width: ITHouseScale(40), height: ITHouseScale(40)))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(ITHouseScale(13))
            make.top.equalTo(self.imgView.snp.bottom).offset(ITHouseScale(10))
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom).offset(ITHouseScale(5))
        }
    }
    
    ///填充数据
    func configCell(title: String?) {
        titleLabel.text = title
        subTitleLabel.text = "+8414"
    }
    
}
