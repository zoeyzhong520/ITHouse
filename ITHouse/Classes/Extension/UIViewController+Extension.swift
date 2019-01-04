//
//  UIViewController+Extension.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

enum Position: Int {
    case Left = 0
    case Right = 1
}

extension UIViewController {
    
    ///根据类名进行Push并传值
    func push(ofClassName className: String, andParamDict paramsDict: [String : Any]? = nil) {
        if className.count == 0 {
            return
        }
        
        let t_className = String.AppName! + "." + className
        guard let t_vc = NSClassFromString(t_className) as? UIViewController.Type else {
            fatalError("创建\(t_className)类出错")
        }
        let vc = t_vc.init()
        
        if paramsDict != nil {
            for (key, value) in paramsDict! {
                vc.setValue(value, forKey: key)
            }
        }
        
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    ///创建图片类型UIBarButtonItem
    func addBarButtonItem(position: Position, image: UIImage?, action: Selector?) {
        let barButtonItem = UIBarButtonItem(image: image?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: action)
        if position == .Left {
            navigationItem.leftBarButtonItem = barButtonItem
        } else {
            navigationItem.rightBarButtonItem = barButtonItem
        }
    }
    
    ///创建标题类型UIBarButtonItem
    func addBarButtonItem(position: Position, title: String?, action: Selector?) {
        let barButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        if position == .Left {
            navigationItem.leftBarButtonItem = barButtonItem
        } else {
            navigationItem.rightBarButtonItem = barButtonItem
        }
    }
    
    ///获取当前视图的topViewController
    func topViewController(rootViewController: UIViewController) -> UIViewController? {
        if rootViewController.isKind(of: UITabBarController.self) {
            let viewController = rootViewController as! UITabBarController
            return topViewController(rootViewController: viewController.selectedViewController!)
        } else if rootViewController.isKind(of: UINavigationController.self) {
            let viewController = rootViewController as! UINavigationController
            return topViewController(rootViewController: viewController.visibleViewController!)
        } else if rootViewController.presentedViewController != nil {
            return topViewController(rootViewController: rootViewController.presentedViewController!)
        }
        return rootViewController
    }
    
    ///显示登录页
    func showLogin() {
        push(ofClassName: "LoginViewController")
    }
    
    ///跳转到扫一扫
    func showQRCode(withTitle title: String?=nil, delegate: QRCodeViewControllerDelegate?) {
        let vc = QRCodeViewController()
        vc.title = title
        vc.delegate = delegate
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    ///弹框
    func showAlert(withMessage message: String?, andAction actionBlock: (() -> Void)?=nil) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: { (action) in
            if actionBlock != nil {
                actionBlock!()
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}
