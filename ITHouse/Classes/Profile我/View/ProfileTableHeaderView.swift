//
//  ProfileTableHeaderView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/3/7.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ProfileTableHeaderView: UIView {

    ///ProfileTableHeaderView的高度
    private(set) var viewHeight = ITHouseScale(60+80+40*2)
    
    ///登录按钮
    fileprivate lazy var loginBtn: UIButton = {
        let view = UIButton(title: "登录/注册", titleColor: UIColor.blackTextColor, font: UIFont.navTitleFont, target: self, action: #selector(loginAction))
        view.frame = CGRect(x: (SCREEN_WIDTH-ITHouseScale(120))/2, y: ITHouseScale(40), width: ITHouseScale(120), height: ITHouseScale(40))
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ITHouseScale(20)
        view.backgroundColor = UIColor.lightGrayColor
        return view
    }()
    
    ///三方登陆View的高度
    fileprivate let otherLoginMethodsView_Height = ITHouseScale(60)
    ///子功能View的高度
    fileprivate let childMethodsView_Height = ITHouseScale(80)
    
    ///三方登陆View
    lazy var otherLoginMethodsView: OtherLoginMethodsView = {
        let view = OtherLoginMethodsView(frame: CGRect(x: ITHouseScale(50), y: loginBtn.frame.maxY, width: SCREEN_WIDTH-ITHouseScale(50*2), height: otherLoginMethodsView_Height))
        return view
    }()
    
    ///子功能View
    lazy var childMethodsView: ChildMethodsView = {
        let view = ChildMethodsView(frame: CGRect(x: 0, y: otherLoginMethodsView.frame.maxY, width: SCREEN_WIDTH, height: childMethodsView_Height))
        return view
    }()
    
    ///分割线
    fileprivate lazy var lineView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: ITHouseScale(20), y: otherLoginMethodsView.frame.maxY, width: SCREEN_WIDTH - ITHouseScale(20*2), height: 1)
        view.backgroundColor = UIColor.lightGrayColor
        return view
    }()
    
    ///分割条
    fileprivate lazy var bottomLine: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: childMethodsView.frame.maxY, width: SCREEN_WIDTH, height: ITHouseScale(10))
        view.backgroundColor = UIColor.lightGrayColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - function
    
    fileprivate func addViews() {
        
        backgroundColor = UIColor.white
        
        addSubview(loginBtn)
        addSubview(otherLoginMethodsView)
        addSubview(childMethodsView)
        
        addSubview(lineView)
        addSubview(bottomLine)
    }
    
    @objc fileprivate func loginAction() {
        DLog("登录/注册")
    }
    
}

extension ProfileTableHeaderView {
    
    ///获取View的高度
    class func getViewHeight() -> CGFloat {
        return ITHouseScale(60+80+40*2+10)
    }
    
}
