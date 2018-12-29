//
//  NewsCalendarViewController.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/12/29.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

///News-日历
class NewsCalendarViewController: UITableViewController {

    ///日历
    fileprivate lazy var calendarView: DAYCalendarView = {
        let view = DAYCalendarView()
        view.addTarget(self, action: #selector(calendarViewValueChanded(_:)), for: .valueChanged)
        return view
    }()
    ///日历高度
    fileprivate let calendarViewHeight = ITHouseScale(260)
    
    ///scrollBar高度
    fileprivate let scrollBarHeight = ITHouseScale(50)
    fileprivate lazy var scrollBar: CommonScrollBar = {
        let bar = CommonScrollBar(frame: CGRect(x: 0, y: calendarViewHeight, width: SCREEN_WIDTH, height: scrollBarHeight), btnNames: ["要闻推送","当日新闻","事件","浏览历史"])
        bar.backgroundColor = RGB(238,236,238)
        bar.delegate = self
        return bar
    }()
    
    ///tableHeaderView
    fileprivate lazy var tableHeaderView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: calendarViewHeight+scrollBarHeight)
        return view
    }()
    
    ///数据模型
    fileprivate var model: NewsDetailNewsPhotoTextModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
        getData()
    }
    
    fileprivate func setPage() {
        title = TimeTransferTool.nowDateString(withDateFormat: "yyyy-MM-dd")
        tableHeaderView.addSubview(calendarView)
        tableHeaderView.addSubview(scrollBar)
        tableView.tableHeaderView = tableHeaderView
        tableView.registerClassOf(NewsDetailPhotoTextTypeCell.self)
    }
    
    override func viewWillLayoutSubviews() {
        calendarView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(self.calendarViewHeight)
        }
    }

    fileprivate func getData() {
        ITHouseHttpTool.newsPhotoTextData { [weak self] (model) in
            self?.model = model
            self?.tableView.reloadData()
        }
    }
    
    @objc func calendarViewValueChanded(_ calendarView: DAYCalendarView) {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let str = df.string(from: calendarView.selectedDate)
        DLog(str)
        title = str
    }
}

extension NewsCalendarViewController: CommonScrollBarDelegate {
    
    func didSelectWithIndex(index: Int) {
        getData()
    }
}

extension NewsCalendarViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.newsPhotoText?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.model?.newsPhotoText?[indexPath.row].rowHeight ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsDetailPhotoTextTypeCell = tableView.dequeueReusableCell()
        cell.model = self.model?.newsPhotoText?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
