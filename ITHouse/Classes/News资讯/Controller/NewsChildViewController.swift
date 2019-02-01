//
//  NewsChildViewController.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

///News-子控制器
class NewsChildViewController: BaseViewController {
    
    ///设置frame
    fileprivate let t_frame = CGRect(x: 0, y: ITHouseScale(40), width: SCREEN_WIDTH, height: CONTENT_HEIGHT - TAB_HEIGHT - ITHouseScale(40))
    
    ///view的type
    var viewType: NewsDetailViewType?
    
    ///WithBannerTypeView
    fileprivate lazy var withBannerTypeView: NewsDetailWithBannerTypeView = {
        let view = NewsDetailWithBannerTypeView(frame: t_frame)
        view.delegate = self
        return view
    }()
    
    ///rankingTypeView
    fileprivate lazy var rankingTypeView: NewsDetailRankingTypeView = {
        let view = NewsDetailRankingTypeView(frame: t_frame)
        view.delegate = self
        return view
    }()
    
    ///photoTextTypeView
    fileprivate lazy var photoTextTypeView: NewsDetailPhotoTextTypeView = {
        let view = NewsDetailPhotoTextTypeView(frame: t_frame)
        view.delegate = self
        return view
    }()
    
    ///hotReviewTypeView
    fileprivate lazy var hotReviewTypeView: NewsDetailHotReviewTypeView = {
        let view = NewsDetailHotReviewTypeView(frame: t_frame)
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if viewType == NewsChildViewController.NewsDetailViewType.WithBannerType {
            withBannerTypeView.bannerView.createTimer()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        if viewType == NewsChildViewController.NewsDetailViewType.WithBannerType {
            withBannerTypeView.bannerView.releaseTimer()
        }
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
            ITHouseHttpTool.newsHotReviewData { [weak self] (model) in
                self?.hotReviewTypeView.model = model
            }
        case .none:
            DLog("viewType is nil")
        }
    }
}

extension NewsChildViewController {
    
    enum NewsDetailViewType: Int {
        case WithBannerType = 0//带有banner
        case RankingType//排行
        case PhotoTextType//图文
        case HotReviewType//热评
    }
}

extension NewsChildViewController: NewsDetailWithBannerTypeViewDelegate {
    
    func didSelectCell(withModel model: NewsDetailNew?) {
        push(ofClassName: "NewsDetailViewController")
    }
}

extension NewsChildViewController: NewsDetailRankingTypeViewDelegate {
    
    func didSelectRankingCell(withModel model: NewsDetailNewsRankingList?) {
        push(ofClassName: "NewsDetailViewController")
    }
    
    func didSelectRankingSpicyCell(withModel model: NewsDetailNewsRankingList?) {
        //辣品
        
    }
}

extension NewsChildViewController: NewsDetailPhotoTextTypeViewDelegate {
    
    func didSelecPhotoTextCell(withModel model: NewsDetailNewsPhotoText?) {
        push(ofClassName: "NewsDetailViewController")
    }
}

extension NewsChildViewController: NewsDetailHotReviewTypeViewDelegate {
    
    func didSelectHotReviewCell(withModel model: NewsDetailHotReview?) {
        push(ofClassName: "NewsDetailViewController")
    }
}
