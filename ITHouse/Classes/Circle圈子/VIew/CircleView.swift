//
//  CircleView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/2/25.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

@objc protocol CircleViewDelegate: NSObjectProtocol {
    @objc optional
    func circleView_scrollViewDidScroll(scrollView: UIScrollView)
    func circleView_didSelectRow(model: CircleListModel?)
}

class CircleView: UIView {

    weak var delegate: CircleViewDelegate?
    
    ///模型
    var model: CircleModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    ///tableView
    fileprivate lazy var tableView: UITableView = {
        let tbView = UITableView(frame: bounds, style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.registerClassOf(CircleTableViewCell.self)
        tbView.rowHeight = ITHouseScale(110)
        tbView.separatorStyle = .none
        return tbView
        
    }()
    
    ///tableHeaderViewHeight
    fileprivate let tableHeaderViewHeight = ITHouseScale(150)
    
    ///tableHeaderView
    lazy var tableHeaderView: CircleHeaderView = {
        let view = CircleHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: tableHeaderViewHeight))
        view.backgroundColor = UIColor.white
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
        addSubview(tableView)
        tableView.tableHeaderView = tableHeaderView
    }

}

extension CircleView: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.circleList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CircleTableViewCell = tableView.dequeueReusableCell()
        cell.model = self.model?.circleList?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.circleView_didSelectRow(model: self.model?.circleList?[indexPath.row])
        }
    }
    
}

extension CircleView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if delegate != nil {
            delegate?.circleView_scrollViewDidScroll!(scrollView: scrollView)
        }
    }
    
}
