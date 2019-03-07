//
//  CirclePublishTypeAlertView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/2/1.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class CirclePublishTypeAlertView: UIView {

    ///block
    var block: ((String) -> Void)?
    
    ///模型数组
    var circleModel: CircleModel? {
        didSet {
            dataArray = circleModel?.publishTypeDescription?.first
            leftTableView.reloadData()
        }
    }

    ///右边tbView数据源
    fileprivate var dataArray: [String]? {
        didSet {
            rightTableView.reloadData()
        }
    }
    
    ///contentViewHeight
    fileprivate let contentViewHeight = SCREEN_HEIGHT/2
    
    ///contentView
    fileprivate var contentView: UIView?
    
    ///leftTableView
    fileprivate lazy var leftTableView: UITableView = {
        let tbView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH/3, height: contentViewHeight), style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.registerClassOf(UITableViewCell.self)
        tbView.separatorStyle = .none
        return tbView
    }()
    
    ///rightTableView
    fileprivate lazy var rightTableView: UITableView = {
        let tbView = UITableView(frame: CGRect(x: leftTableView.frame.maxX, y: 0, width: SCREEN_WIDTH/3*2, height: contentViewHeight), style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.registerClassOf(UITableViewCell.self)
        tbView.separatorStyle = .none
        return tbView
    }()
    
    //左边tbView选中的title.
    fileprivate var leftTitle = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addViews() {
        backgroundColor = RGBA(0,0,0,0.4)
//        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        
        if contentView == nil {
            contentView = UIView()
            contentView?.backgroundColor = UIColor.white
            addSubview(contentView!)
            contentView?.snp.makeConstraints({ (make) in
                make.left.right.equalToSuperview()
                make.bottom.equalTo(self.snp.top)
                make.height.equalTo(self.contentViewHeight)
            })
            
            //config contentView
            configContentView()
        }
        
    }
    
    //MARK: - function
    
    fileprivate func configContentView() {
        contentView?.addSubview(leftTableView)
        contentView?.addSubview(rightTableView)
    }
    
    func show() {
        alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.alpha = 1
            
            guard let window = UIApplication.shared.delegate?.window else {
                fatalError("Window is nil.")
            }
            window?.addSubview(self)
            
            self.contentView?.transform = CGAffineTransform(translationX: 0, y: self.contentViewHeight)
            
        }, completion: nil)
    }
    
    @objc func hide() {
        alpha = 1
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 0
            self.contentView?.transform = CGAffineTransform.identity
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
}

extension CirclePublishTypeAlertView: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return self.circleModel?.publishType?.count ?? 0
        } else {
            return self.dataArray?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell()
        cell.textLabel?.font = UIFont.titleFont
        cell.textLabel?.textColor = UIColor.blackTextColor
        if tableView == leftTableView {
            cell.textLabel?.text = self.circleModel?.publishType?[indexPath.row]
        } else {
            cell.textLabel?.text = self.dataArray?[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == leftTableView {
            leftTitle = self.circleModel?.publishType?[indexPath.row] ?? ""
            
            self.dataArray = self.circleModel?.publishTypeDescription?[indexPath.row]
            rightTableView.reloadData()
        } else {
            
            if block != nil {
                let title = (leftTitle == "" ? (self.circleModel?.publishType?.first ?? "") : leftTitle) + " > " + (self.dataArray?[indexPath.row] ?? "")
                DLog(title)
                block!(title)
            }
            
            hide()
        }
    }
    
}
