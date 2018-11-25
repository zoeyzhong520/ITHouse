//
//  BaseNavigationViewController.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

extension BaseNavigationViewController:UIGestureRecognizerDelegate {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        let cnt = navigationController?.viewControllers.count ?? 0
        if cnt > 0 {
            let backItem = UIBarButtonItem(image: UIImage.backImg?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backAction))
            navigationItem.leftBarButtonItem = backItem
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    ///backAction
    @objc fileprivate func backAction() {
        popViewController(animated: true)
    }
}
