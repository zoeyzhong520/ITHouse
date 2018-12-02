//
//  NewsDetailHotReviewTypeView.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class NewsDetailHotReviewTypeView: UIView {

    ///数据模型
    var model: NewsDetailHotReviewModel? {
        didSet {
            
        }
    }
    
    ///tableView
    fileprivate lazy var tableView: UITableView = {
        let tbView = UITableView(frame: bounds, style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        return
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
