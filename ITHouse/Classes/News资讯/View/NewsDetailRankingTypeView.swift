//
//  NewsDetailRankingTypeView.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class NewsDetailRankingTypeView: UIView {

    ///数据模型
    var model: NewsDetailNewsRankingModel? {
        didSet {
            createTableHeaderView()
            tableView.reloadData()
        }
    }
    
    ///tableHeaderView
    fileprivate lazy var tableHeaderView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: ITHouseScale(50)))
        return view
    }()
    
    ///选中的headerBtn
    fileprivate var selectedHeaderBtn: UIButton!
    
    ///tableView
    fileprivate lazy var tableView: UITableView = {
        let tbView = UITableView(frame: bounds, style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.rowHeight = ITHouseScale(100)
        tbView.sectionHeaderHeight = ITHouseScale(50)
        tbView.separatorStyle = .none
        tbView.registerClassOf(NewsDetailRankingTypeSpicyCell.self)
        tbView.registerClassOf(NewsDetailRankingTypeCell.self)
        return tbView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///UI
    fileprivate func addViews() {
        addSubview(tableView)
        tableView.tableHeaderView = self.tableHeaderView
    }
    
    ///设置tableHeaderView
    fileprivate func createTableHeaderView() {
        for view in tableHeaderView.subviews {
            view.removeFromSuperview()
        }
        
        let scrollView = UIScrollView(frame: tableHeaderView.bounds)
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: 0)
        tableHeaderView.addSubview(scrollView)
        
        var btnNames = [String]()
        if let newsRanking = model?.newsRanking {
            for item in newsRanking {
                if item.title != nil {
                    btnNames.append(item.title!)
                }
            }
        }
        
        let btnMargin = ITHouseScale(15)
        let btnWidth = (bounds.size.width - btnMargin*CGFloat(btnNames.count+1)) / CGFloat(btnNames.count)
        let btnHeight = bounds.size.height
        for i in 0..<btnNames.count {
            let btn = UIButton(title: btnNames[i], titleColor: UIColor.blackTextColor, font: UIFont.titleFont, target: self, action: #selector(headerBtnClick(_:)))
            btn.frame = CGRect(x: CGFloat(i)*(btnWidth+btnMargin)+btnMargin, y: 0, width: btnWidth, height: btnHeight)
            btn.tag = i
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = btnHeight/2
            btn.backgroundColor = UIColor.grayTextColor
            scrollView.addSubview(btn)
            
            if i == 0 {
                selectedHeaderBtn = btn
                selectedHeaderBtn.backgroundColor = UIColor.mainColor
                selectedHeaderBtn.setTitleColor(UIColor.white, for: .normal)
            }
        }
        
        scrollView.contentSize = CGSize(width: (btnWidth+btnMargin)*CGFloat(btnNames.count)+btnMargin, height: 0)
    }
    
    @objc fileprivate func headerBtnClick(_ button: UIButton) {
        if selectedHeaderBtn != button {
            //button为当前选中的按钮
            button.backgroundColor = UIColor.mainColor
            button.setTitleColor(UIColor.white, for: .normal)
            
            selectedHeaderBtn.backgroundColor = UIColor.grayTextColor
            selectedHeaderBtn.setTitleColor(UIColor.blackTextColor, for: .normal)
        }
        selectedHeaderBtn = button
        
        //点击按钮后切换到对应的section
        if let newsRanking = model?.newsRanking {
            if button.tag < newsRanking.count - 1 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: button.tag), at: .bottom, animated: true)
            }
        }
    }
}

extension NewsDetailRankingTypeView:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model?.newsRanking?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.newsRanking?[section].list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if model?.newsRanking?[indexPath.section].type == "1" {
            let cell:NewsDetailRankingTypeSpicyCell = tableView.dequeueReusableCell()
            cell.indexPath = indexPath
            cell.model = self.model?.newsRanking?[indexPath.row].list?[indexPath.row]
            return cell
        } else {
            let cell:NewsDetailRankingTypeCell = tableView.dequeueReusableCell()
            cell.indexPath = indexPath
            cell.model = self.model?.newsRanking?[indexPath.section].list?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model?.newsRanking?[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
