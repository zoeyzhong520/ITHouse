//
//  SearchToolView.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/12/29.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class SearchToolView: UIView {

    ///数据模型
    var model: SearchToolModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    ///tableView
    fileprivate lazy var tableView: UITableView = {
        let tbView = UITableView(frame: CGRect(x: 0, y: ITHouseScale(10), width: bounds.size.width, height: bounds.size.height-ITHouseScale(10)), style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.registerClassOf(SearchToolHotCell.self)
        tbView.registerClassOf(SearchToolReadHistoryCell.self)
        tbView.separatorStyle = .none
        tbView.rowHeight = ITHouseScale(40)
        return tbView
    }()
    
    ///分组标题数组
    fileprivate let sectionTitles = ["热门搜索","阅读历史"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addViews(){
        addSubview(tableView)
    }

}

extension SearchToolView: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sectionTitles[indexPath.section] == "热门搜索" {
            return self.model?.hotRowHeight ?? 0
        } else {
            return ITHouseScale(40)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionTitles[section] == "热门搜索" {
            return 1
        } else {
            return model?.history?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if sectionTitles[indexPath.section] == "热门搜索" {
            let cell:SearchToolHotCell = tableView.dequeueReusableCell()
            cell.configData(btnNames: self.model?.hot)
            return cell
        } else {
            let cell:SearchToolReadHistoryCell = tableView.dequeueReusableCell()
            cell.configData(content: self.model?.history?[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
