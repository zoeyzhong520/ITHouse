//
//  NewsDetailRankingTypeHeaderView.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/12/1.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class NewsDetailRankingTypeHeaderView: UITableViewHeaderFooterView {

    ///数据源（String字符串）
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    ///标题
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.navTitleFont, titleColor: UIColor.blackTextColor, alignment: .left)
        return label
    }()
    
    ///图标
    fileprivate lazy var imgView: UIImageView = {
        return UIImageView(image: UIImage.rankingImg)
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///UI
    fileprivate func addViews() {
        addSubview(imgView)
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(ITHouseScale(20))
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: ITHouseScale(22), height: ITHouseScale(22)))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(ITHouseScale(5))
            make.top.bottom.right.equalToSuperview()
        }
    }
}
