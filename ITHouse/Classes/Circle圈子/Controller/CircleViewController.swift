//
//  CircleViewController.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

///圈子
class CircleViewController: BaseViewController {

    fileprivate var circleModel: CircleModel!
    
    ///CircleView
    fileprivate lazy var circleView: CircleView = {
        let view = CircleView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: CONTENT_HEIGHT-TAB_HEIGHT))
        view.delegate = self
        return view
    }()
    
    ///baseTitlesView的原始位置
    fileprivate var originFrame = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        getData()
        setPage()
        
    }
    
    fileprivate func setNavigation() {
        let searchItem = UIBarButtonItem(image: UIImage.searchImg?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(search))
        let publishItem = UIBarButtonItem(image: UIImage.publishImg?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(publish))
        navigationItem.rightBarButtonItems = [searchItem,publishItem]
    }
    
    fileprivate func getData() {
        ITHouseHttpTool.circleData { [weak self] (dataDict) in
            let model = CircleModel.initModel(dict: dataDict)
            self?.circleModel = model
            self?.circleView.tableHeaderView.model = model
        }
        
        ITHouseHttpTool.circleDataWithModel { [weak self] (model) in
            self?.circleView.model = model
        }
    }
    
    fileprivate func setPage() {
        view.addSubview(circleView)
        //记录原始位置
        originFrame = circleView.tableHeaderView.baseTitlesView.frame
    }
    
    //MARK: - function
    
    @objc fileprivate func search() {
        push(ofClassName: "SearchToolViewController")
    }
    
    @objc fileprivate func publish() {
        //发表
        present(ofClassName: "CirclePublishViewController", andParamDict: ["circleModel": circleModel])
    }

}

extension CircleViewController: CircleViewDelegate {
    
    func circleView_scrollViewDidScroll(scrollView: UIScrollView) {
        
//        DLog(scrollView.contentOffset)
        
        //headerView的UICollectionView的高度
        let collectionViewHeight = ITHouseScale(100)
        if scrollView.contentOffset.y >= collectionViewHeight {
            circleView.tableHeaderView.baseTitlesView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: ITHouseScale(40))
            view.addSubview(circleView.tableHeaderView.baseTitlesView)
        } else {
            circleView.tableHeaderView.baseTitlesView.frame = originFrame
            circleView.tableHeaderView.addSubview(circleView.tableHeaderView.baseTitlesView)
        }
        
    }
    
    
    func circleView_didSelectRow(model: CircleListModel?) {
        //进入详情页
        push(ofClassName: "NewsDetailViewController")
    }
    
}
