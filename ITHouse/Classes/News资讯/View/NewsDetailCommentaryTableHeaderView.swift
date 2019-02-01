//
//  NewsDetailCommentaryTableHeaderView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/21.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

///News-详情-查看评论 TableHeaderView
class NewsDetailCommentaryTableHeaderView: UIView {
    
    ///标题
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    ///标题
    fileprivate lazy var titleLabel: UILabel = {
        let view = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.blackTextColor, alignment: .left)
        view.backgroundColor = UIColor.lightGray
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 3
        return view
    }()
    
    ///分割线
    fileprivate lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
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
        addSubview(titleLabel)
        addSubview(lineView)
    }
    
    override func layoutSubviews() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(ITHouseScale(10))
            make.right.equalTo(-ITHouseScale(10))
            make.height.equalTo(ITHouseScale(15))
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }

}
