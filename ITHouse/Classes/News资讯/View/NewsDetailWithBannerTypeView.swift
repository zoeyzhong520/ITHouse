//
//  NewsDetailWithBannerTypeView.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class NewsDetailWithBannerTypeView: UIView {

    ///数据模型
    var model: NewsDetailNewsModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    ///banner view
    lazy var bannerView: BorderShownCardsView = {
        let view = BorderShownCardsView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: ITHouseScale(100)))
        return view
    }()

    ///tableView
    fileprivate lazy var tableView: UITableView = {
        let tbView = UITableView(frame: bounds, style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.rowHeight = ITHouseScale(100)
        tbView.sectionHeaderHeight = ITHouseScale(100)
        tbView.separatorStyle = .none
        tbView.registerClassOf(NewsDetailWithBannerTypeCell.self)
        return tbView
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
        addSubview(tableView)
        tableView.tableHeaderView = bannerView
    }
}

extension NewsDetailWithBannerTypeView:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.news?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NewsDetailWithBannerTypeCell = tableView.dequeueReusableCell()
        cell.model = self.model?.news?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
