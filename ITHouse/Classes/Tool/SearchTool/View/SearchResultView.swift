//
//  SearchResultView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/2.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

///搜索结果
class SearchResultView: UIView {

    ///数据模型
    var model: SearchResultModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    ///tableView
    fileprivate lazy var tableView: UITableView = {
        let tbView = UITableView(frame: CGRect(x: 0, y: ITHouseScale(10), width: bounds.size.width, height: bounds.size.height-ITHouseScale(10)), style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.registerClassOf(SearchResultCell.self)
        tbView.rowHeight = ITHouseScale(75)
        tbView.separatorStyle = .none
        return tbView
    }()
    
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

extension SearchResultView: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SearchResultCell = tableView.dequeueReusableCell()
        cell.model = self.model?.result?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
