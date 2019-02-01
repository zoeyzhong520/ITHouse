//
//  NewsDetailCommentaryView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/21.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

///News-详情-查看评论
class NewsDetailCommentaryView: UIView {

    ///数据模型
    var model: NewsDetailCommentaryModel? {
        didSet {
            tableHeaderView.titleText = model?.newsTitle
            tableView.reloadData()
        }
    }
    
    ///tableView
    fileprivate lazy var tableView: UITableView = {
        let view = UITableView(frame: bounds, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.sectionHeaderHeight = ITHouseScale(50)
        view.registerClassOf(NewsDetailCommentaryCell.self)
        return view
    }()
    
    ///tableHeaderView
    fileprivate lazy var tableHeaderView: NewsDetailCommentaryTableHeaderView = {
        let view = NewsDetailCommentaryTableHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: ITHouseScale(35)))
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

extension NewsDetailCommentaryView: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.model?.newsCommentary?[indexPath.row].rowHeight ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.newsCommentary?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NewsDetailCommentaryCell = tableView.dequeueReusableCell()
        cell.model = self.model?.newsCommentary?[indexPath.row]
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: ITHouseScale(50)))
        header.backgroundColor = UIColor.white
        
        let label = UILabel(title: "  热门评论  ", titleFont: UIFont.navTitleFont, titleColor: UIColor.white, alignment: .left)
        label.backgroundColor = UIColor.mainColor
        label.frame = CGRect(x: 0, y: (header.bounds.size.height-ITHouseScale(15))/2, width: label.text!.textWidth(font: UIFont.navTitleFont), height: ITHouseScale(20))
        header.addSubview(label)
        
        let maskPath = UIBezierPath(roundedRect: label.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.topRight.rawValue | UIRectCorner.bottomRight.rawValue), cornerRadii: CGSize(width: ITHouseScale(10), height: ITHouseScale(10)))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = label.bounds
        maskLayer.path = maskPath.cgPath
        label.layer.mask = maskLayer
        
        return header
    }
}

extension NewsDetailCommentaryView: NewsDetailCommentaryCellDelegate {
    
    func clickBtn(withTag tag: Int, model: NewsDetailCommentary?) {
        if tag == 0 {
            //展开
            let view = NewsDetailMoreCommentaryView(frame: .zero)
            view.model = model
            view.childViewModel = self.model
            view.show()
            
        }
        
        if tag == 1 {
            //回复
            
        }
    }
}

extension NewsDetailCommentaryView: UIScrollViewDelegate {
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let sectionHeaderHeight = ITHouseScale(50)
//        if scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= sectionHeaderHeight {
//            scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
//        } else if scrollView.contentOffset.y >= sectionHeaderHeight {
//            scrollView.contentInset = UIEdgeInsets(top: -sectionHeaderHeight, left: 0, bottom: 0, right: 0)
//        }
//    }
}
