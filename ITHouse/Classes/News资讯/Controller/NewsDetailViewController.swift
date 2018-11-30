//
//  NewsDetailViewController.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class NewsDetailViewController: BaseViewController {
    
    ///view的type
    var viewType: NewsDetailViewType? {
        didSet {
            getData()
        }
    }
    
    ///WithBannerTypeView
    fileprivate lazy var withBannerTypeView: NewsDetailWithBannerTypeView = {
        let view = NewsDetailWithBannerTypeView(frame: self.view.bounds)
        return view
    }()
    
    ///rankingTypeView
    fileprivate lazy var rankingTypeView: NewsDetailRankingTypeView = {
        let view = NewsDetailRankingTypeView(frame: self.view.bounds)
        return view
    }()
    
    ///photoTextTypeView
    fileprivate lazy var photoTextTypeView: NewsDetailPhotoTextTypeView = {
        let view = NewsDetailPhotoTextTypeView(frame: self.view.bounds)
        return view
    }()
    
    ///hotReviewTypeView
    fileprivate lazy var hotReviewTypeView: NewsDetailHotReviewTypeView = {
        let view = NewsDetailHotReviewTypeView(frame: self.view.bounds)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    ///获取数据
    fileprivate func getData() {
        
        switch viewType {
        case .WithBannerType?:
            DLog(viewType!.rawValue)
            view.addSubview(withBannerTypeView)
            ITHouseHttpTool.newsBannerData { [weak self] (model) in
                self?.withBannerTypeView.bannerView.images = model.images
            }
            ITHouseHttpTool.newsNewsData { [weak self] (model) in
                self?.withBannerTypeView.model = model
            }
        case .RankingType?:
            DLog(viewType!.rawValue)
            view.addSubview(rankingTypeView)
            ITHouseHttpTool.newsRankingData { [weak self] (model) in
                self?.rankingTypeView.model = model
            }
        case .PhotoTextType?:
            DLog(viewType!.rawValue)
            view.addSubview(photoTextTypeView)
            ITHouseHttpTool.newsPhotoTextData { [weak self] (model) in
                self?.photoTextTypeView.model = model
            }
        case .HotReviewType?:
            DLog(viewType!.rawValue)
            view.addSubview(hotReviewTypeView)
        case .none:
            DLog("viewType is nil")
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.frame = CGRect(x: 0, y: STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT, width: SCREEN_WIDTH, height: CONTENT_HEIGHT - TAB_HEIGHT)
    }
}

extension NewsDetailViewController {
    
    enum NewsDetailViewType: Int {
        case WithBannerType = 0
        case RankingType
        case PhotoTextType
        case HotReviewType
    }
}
