//
//  ShareTool.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/4.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ShareTool: UIView {

    ///collectionView
    
    ///取消按钮
    fileprivate lazy var cancelBtn: UIButton = {
        let view = UIButton(title: "取消", titleColor: UIColor.blackTextColor, font: UIFont.textFont, target: self, action: #selector(cancelBtnClick))
        view.backgroundColor = UIColor.lightGrayColor
        view.layer.masksToBounds = true
//        view.layer.cornerRadius =
        return view
    }()
    
    ///flowBtnsView
    fileprivate lazy var flowBtnsView: UIView = {
        let view = UIView()
        view.backgroundColor = RandomColor
        view.layer.masksToBounds = true
//        view.layer.cornerRadius =
        return view
    }()
    
    ///contentViewHeight
    fileprivate var contentViewHeight = ITHouseScale(200)
    ///contentView
    fileprivate var contentView: UIView?
    
    @objc fileprivate func cancelBtnClick() {
        
    }

}
