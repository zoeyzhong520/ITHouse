//
//  NewsViewController.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

///News
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
        let addItem = UIBarButtonItem(image: UIImage.addImg?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(addClick(_:)))
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
        
        guard let columns = model.columns, let moreColumns = model.moreColumns else {
            fatalError("columns或者moreColumns为nil")
        }
        
        for (index, column) in columns.enumerated() {
            if column.name != nil {
                //创建标题数组
                menu.titles.append(column.name!)
                //创建控制器数组
                let vc = NewsChildViewController()
                if index == 0 {
                    vc.viewType = NewsChildViewController.NewsDetailViewType.WithBannerType
                } else if index == 1 {
                    vc.viewType = NewsChildViewController.NewsDetailViewType.RankingType
                } else if index == 2 {
                    vc.viewType = NewsChildViewController.NewsDetailViewType.PhotoTextType
                } else {
                    vc.viewType = NewsChildViewController.NewsDetailViewType.HotReviewType
                }
                menu.dataSource.add(vc)
            }
        }
        
        for (_, moreColum) in moreColumns.enumerated() {
            if moreColum.name != nil {
                menu.viceTitles.append(moreColum.name!)
            }
        }
        addChild(menu)//加入导航控制器
        view.addSubview(menu.view)
    }
    
    @objc fileprivate func addClick(_ item: UIBarButtonItem) {//添加popover视图
        let vc = PopoverToolListViewController()
        vc.dataSource = ["金币任务","投稿","扫一扫","反馈"]
        vc.anchorBarBtnItem = item
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @objc fileprivate func searchClick() {//点击搜索
        push(ofClassName: "SearchToolViewController")
    }
    
    @objc fileprivate func calendarClick() {//点击日历
        push(ofClassName: "NewsCalendarViewController")
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

extension NewsViewController: PopoverToolListViewControllerDelegate {
    
    func didSelectItem(withIndex index: Int) {
        switch index {
        case 2://扫一扫
            showQRCode(withTitle: "扫扫看", delegate: self)
        default:
            DLog(index)
        }
    }
}

extension NewsViewController: QRCodeViewControllerDelegate {
    
    func scanMessage(_ message: String, andQRCodeVC QRCodeVC: QRCodeViewController) {
        showAlert(withMessage: message) { [weak self] in
            QRCodeVC.navigationController?.popViewController(animated: true)
            self?.push(ofClassName: "BaseWebViewController", andParamDict: ["urlString": "https://www.baidu.com"])
        }
    }
}
