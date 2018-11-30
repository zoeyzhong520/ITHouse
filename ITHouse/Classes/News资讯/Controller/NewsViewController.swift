//
//  NewsViewController.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class NewsViewController: BaseViewController {
    
    ///顶部滚动菜单对象
    fileprivate var menu: TopScrollingMenuViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNav()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    ///UI
    fileprivate func createNav() {
        let addItem = UIBarButtonItem(image: UIImage.addImg?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(addClick))
        let searchItem = UIBarButtonItem(image: UIImage.searchImg?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchClick))
        let calendarItem = UIBarButtonItem(image: UIImage.calendarImg?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(calendarClick))
        navigationItem.rightBarButtonItems = [addItem,searchItem,calendarItem]
    }
    
    ///获取数据
    fileprivate func getData() {
        ITHouseHttpTool.newsColumnsData { [weak self] (model) in
            self?.setTopScrollingMenu(model: model)
        }
    }
    
    ///创建顶部滚动菜单
    fileprivate func setTopScrollingMenu(model: NewsColumnsModel) {
        menu = TopScrollingMenuViewController()
        menu.delegate = self
        
        for (index, column) in (model.columns?.enumerated())! {
            if column.name != nil {
                //创建标题数组
                menu.titles.append(column.name!)
                //创建控制器数组
                let vc = NewsDetailViewController()
                if index == 0 {
                    vc.viewType = NewsDetailViewController.NewsDetailViewType.WithBannerType
                } else {
                    vc.viewType = NewsDetailViewController.NewsDetailViewType.RankingType
                }
                menu.dataSource.add(vc)
            }
        }
        
        for (_, moreColum) in (model.moreColumns?.enumerated())! {
            if moreColum.name != nil {
                menu.viceTitles.append(moreColum.name!)
            }
        }
        navigationController?.addChild(menu)//加入导航控制器
        view.addSubview(menu.view)
    }
    
    @objc fileprivate func addClick() {
        
    }
    
    @objc fileprivate func searchClick() {
        
    }
    
    @objc fileprivate func calendarClick() {
        
    }
}

extension NewsViewController:TopScrollingMenuViewControllerDelegate {
    
    func updateColumnsSqlite(topScrollingMenuViewController: TopScrollingMenuViewController, updateResult: Bool, dataSource: [String]) {
        if updateResult {
            menu.removeFromParent()
            menu.view.removeFromSuperview()
            getData()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                self.menu.reloadData()
            }
        }
    }
}
