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
                menu.titles.append(column.name!)
                
                let vc = BaseViewController()
                vc.view.backgroundColor = index % 2 == 0 ? UIColor.green : UIColor.yellow
                menu.dataSource.add(vc)
            }
        }
        
        for (_, moreColum) in (model.moreColumns?.enumerated())! {
            if moreColum.name != nil {
                menu.viceTitles.append(moreColum.name!)
            }
        }
        addChild(menu)
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
    
    //dataSource: 修改后的我的栏目（String数组）
    func updateColumnsSqlite(topScrollingMenuViewController: TopScrollingMenuViewController, updateResult: Bool, dataSource: [String]) {
        if updateResult {
            DLog(menu.titles)
            DLog(dataSource)
            
            ITHouseHttpTool.newsColumnsData { (model) in
                if menu.titles.count >= dataSource.count {
                    for (index, obj) in menu.titles.enumerated() {
                        if index < dataSource.count && obj != dataSource[index] {
                            DLog("\(index) \(obj)")
                            menu.titles.remove(at: index)
                            menu.dataSource.removeObject(at: index)
                            menu.titles.insert(dataSource[index], at: index)
                            menu.dataSource.insert(BaseViewController(), at: index)
                        }
                    }
                } else {
                    for (index, obj) in dataSource.enumerated() {
                        if index < menu.titles.count && obj != menu.titles[index] {
                            DLog("\(index) \(obj)")
                            menu.titles.remove(at: index)
                            menu.dataSource.removeObject(at: index)
                            menu.titles.insert(obj, at: index)
                            menu.dataSource.insert(BaseViewController(), at: index)
                        }
                    }
                }
                
                menu.viceTitles.removeAll()
                for (_, moreColum) in (model.moreColumns?.enumerated())! {
                    if moreColum.name != nil {
                        menu.viceTitles.append(moreColum.name!)
                    }
                }
            }
        }
        
        menu.reloadData()
    }
}
