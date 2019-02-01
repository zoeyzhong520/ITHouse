//
//  NewsDetailCommentaryViewController.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/21.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

///News-详情-查看评论页
class NewsDetailCommentaryViewController: BaseViewController {

    ///newsBottomBar
    fileprivate lazy var newsBottomBar: NewsBottomBar = {
        let bar = NewsBottomBar(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: newsBottomBarHeight), type: NewsBottomBar.NewsBottomBarType.RefreshType)
        bar.delegate = self
        return bar
    }()
    
    ///NewsDetailCommentaryView
    fileprivate lazy var commentaryView: NewsDetailCommentaryView = {
        let view = NewsDetailCommentaryView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-newsBottomBarHeight))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    fileprivate func setPage() {
        view.addSubview(commentaryView)
        view.addSubview(newsBottomBar)
    }
    
    override func viewWillLayoutSubviews() {
        newsBottomBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(newsBottomBarHeight)
        }
    }
    
    fileprivate func getData() {
        ITHouseHttpTool.newsCommentaryData { [weak self] (model) in
            self?.commentaryView.model = model
        }
    }
}

extension NewsDetailCommentaryViewController: NewsBottomBarDelegate {
    
    func clickBackBtn() {
        navigationController?.popViewController(animated: true)
    }
    
    func didClickBtn(withIndex index: Int) {
        
    }
}

