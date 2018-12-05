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
            tableView.reloadData()
        }
    }
    
    ///tableView
    fileprivate lazy var tableView: UITableView = {
        let tbView = UITableView(frame: bounds, style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.registerClassOf(NewsDetailHotReviewTypeCell.self)
        return tbView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    ///UI
    fileprivate func addViews() {
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NewsDetailHotReviewTypeView:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.newsHotReview?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return model?.newsHotReview?[indexPath.row].rowHeight ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NewsDetailHotReviewTypeCell = tableView.dequeueReusableCell()
        cell.indexPath = indexPath
        cell.model = self.model?.newsHotReview?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
