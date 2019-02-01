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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        
    }
    
    fileprivate func setNavigation() {
        let searchItem = UIBarButtonItem(image: UIImage.searchImg?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(search))
        let publishItem = UIBarButtonItem(image: UIImage.publishImg?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(publish))
        navigationItem.rightBarButtonItems = [searchItem,publishItem]
    }
    
    //MARK: - function
    
    @objc fileprivate func search() {
        push(ofClassName: "SearchToolViewController")
    }
    
    @objc fileprivate func publish() {
        //发表
        present(ofClassName: "CirclePublishViewController")
    }

}
