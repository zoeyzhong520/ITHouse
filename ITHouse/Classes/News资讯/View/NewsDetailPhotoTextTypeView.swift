//
//  NewsDetailPhotoTextTypeView.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

@objc protocol NewsDetailPhotoTextTypeViewDelegate: NSObjectProtocol {
    @objc optional
    func didSelecPhotoTextCell(withModel model: NewsDetailNewsPhotoText?)
}

///图文view
class NewsDetailPhotoTextTypeView: UIView {

    weak var delegate: NewsDetailPhotoTextTypeViewDelegate?
    
    ///数据模型
    var model: NewsDetailNewsPhotoTextModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    ///tableView
    fileprivate lazy var tableView: UITableView = {
        let tbView = UITableView(frame: bounds, style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.separatorStyle = .none
        tbView.registerClassOf(NewsDetailPhotoTextTypeCell.self)
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
    }
}

extension NewsDetailPhotoTextTypeView:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.newsPhotoText?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return model?.newsPhotoText?[indexPath.row].rowHeight ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NewsDetailPhotoTextTypeCell = tableView.dequeueReusableCell()
        cell.model = self.model?.newsPhotoText?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.didSelecPhotoTextCell!(withModel: self.model?.newsPhotoText?[indexPath.row])
        }
    }
}

