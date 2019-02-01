//
//  NewsDetailMoreCommentaryView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/24.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

///News-详情-查看更多评论
class NewsDetailMoreCommentaryView: UIView {

    ///数据模型
    var model: NewsDetailCommentary? {
        didSet {
            tableView.beginUpdates()
            tableHeaderView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: model?.rowHeight ?? 0)
            tableView.tableHeaderView = tableHeaderView
            tableView.endUpdates()
            tableHeaderView.model = model
        }
    }
    
    var childViewModel: NewsDetailCommentaryModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    ///contentViewHeight
    fileprivate let contentViewHeight = SCREEN_HEIGHT*4/5
    
    ///collapseBtnHeight
    fileprivate let collapseBtnHeight = ITHouseScale(50)
    
    ///contentView
    fileprivate var contentView: UIView?
    
    ///收起按钮
    fileprivate lazy var collapseBtn: UIButton = {
        let btn = UIButton(title: "收起", titleColor: UIColor.grayTextColor, font: UIFont.navTitleFont, target: self, action: #selector(btnClick(_:)))
        btn.backgroundColor = UIColor.white
        return btn
    }()
    
    ///tableView
    fileprivate lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: contentViewHeight-collapseBtnHeight), style: .plain)
        view.delegate = self
        view.dataSource = self
        view.registerClassOf(NewsDetailMoreCommentaryCell.self)
        view.separatorStyle = .none
        return view
    }()
    
    ///tableHeaderView
    fileprivate lazy var tableHeaderView: NewsDetailMoreCommentaryTableHeaderView = {
        let view = NewsDetailMoreCommentaryTableHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0))
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
        frame = SCREEN_RECT
        backgroundColor = RGBA(0,0,0,0.4)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        
        if contentView == nil {
            contentView = UIView()
            contentView?.backgroundColor = UIColor.white
            addSubview(contentView!)
            contentView?.snp.makeConstraints({ (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(self.snp.bottom)
                make.height.equalTo(contentViewHeight)
            })
            
            configContentView()
        }
    }

    fileprivate func configContentView() {
        contentView?.addSubview(tableView)
        tableView.tableHeaderView = tableHeaderView
        contentView?.addSubview(collapseBtn)
    }
    
    override func layoutSubviews() {
        collapseBtn.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(collapseBtnHeight)
        }
    }
    
    //MARK: - function
    
    func show() {
        alpha = 0
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
            self.alpha = 1
            if let window = UIApplication.shared.delegate?.window {
                window?.addSubview(self)
            }
            self.contentView?.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -self.contentViewHeight)
        }, completion: nil)
    }
    
    @objc fileprivate func hide() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut, animations: {
            self.alpha = 0
            self.contentView?.transform = CGAffineTransform.identity
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    @objc fileprivate func btnClick(_ button: UIButton) {
        hide()
    }
}

extension NewsDetailMoreCommentaryView: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.childViewModel?.newsCommentary?[indexPath.row].moreCommentaryRowHeight ?? 0) + ITHouseScale(30)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.childViewModel?.newsCommentary?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NewsDetailMoreCommentaryCell = tableView.dequeueReusableCell()
        cell.model = self.childViewModel?.newsCommentary?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
