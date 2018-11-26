//
//  NewsViewController.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class NewsViewController: BaseViewController {

    ///TopScrollingMenuVC对象
    fileprivate lazy var topScrollingMenuVC: TopScrollingMenuViewController = {
        let menuVC = TopScrollingMenuViewController()
        for i in 0..<20 {
            let vc = UIViewController()
//            vc.view.backgroundColor = i%2 == 0 ? .yellow : .green
            menuVC.dataSource.add(vc)
            menuVC.titles.append("\(i*100+100)")
        }
        return menuVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    ///UI
    fileprivate func createUI() {
        addChild(topScrollingMenuVC)
        view.addSubview(topScrollingMenuVC.view)
        
        let addItem = UIBarButtonItem(image: UIImage.addImg?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(addClick))
        let searchItem = UIBarButtonItem(image: UIImage.searchImg?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchClick))
        let calendarItem = UIBarButtonItem(image: UIImage.calendarImg?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(calendarClick))
        navigationItem.rightBarButtonItems = [addItem,searchItem,calendarItem]
    }
    
    @objc fileprivate func addClick() {
        
    }
    
    @objc fileprivate func searchClick() {
        
    }
    
    @objc fileprivate func calendarClick() {
        
    }
}
