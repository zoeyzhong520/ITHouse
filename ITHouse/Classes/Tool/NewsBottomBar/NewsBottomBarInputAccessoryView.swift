//
//  NewsBottomBarInputAccessoryView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/4.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

@objc protocol NewsBottomBarInputAccessoryViewDelegate: NSObjectProtocol {
    @objc optional
    func clickConfirmBtn(withText text: String)
}

///News-键盘上部view
class NewsBottomBarInputAccessoryView: UIView {

    weak var delegate: NewsBottomBarInputAccessoryViewDelegate?
    
    ///输入文本
    var inputText: String? {
        didSet {
            textView.text = inputText
        }
    }
    
    ///帐号管理规范
    fileprivate lazy var ruleLabel: UILabel = {
        let view = UILabel(title: "《帐号管理规范》", titleFont: UIFont.titleFont, titleColor: UIColor.blue, alignment: .right)
        return view
    }()
    
    ///textView
    fileprivate lazy var textView: UITextView = {
        let view = UITextView()
        view.font = UIFont.titleFont
        view.textColor = UIColor.grayTextColor
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ITHouseScale(1)
        return view
    }()
    
    ///登录状态
    fileprivate lazy var loginStatusLabel: UILabel = {
        let view = UILabel(title: UserDefaultsTool.token().count > 0 ? UserDefaultsTool.name() : "未登录", titleFont: UIFont.navTitleFont, titleColor: UIColor.blackTextColor, alignment: .left)
        return view
    }()
    
    ///确认按钮
    fileprivate lazy var confirmBtn: UIButton = {
        let view = UIButton(image: UIImage.confirmImg, target: self, action: #selector(confirmBtnClick))
        view.contentHorizontalAlignment = .right
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addViews() {
        backgroundColor = UIColor.lightGrayColor
        addSubview(ruleLabel)
        addSubview(textView)
        addSubview(loginStatusLabel)
        addSubview(confirmBtn)
    }
    
    override func layoutSubviews() {
        ruleLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.right.equalTo(-ITHouseScale(10))
            make.height.equalTo(ITHouseScale(30))
        }
        
        textView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: ITHouseScale(30), left: ITHouseScale(10), bottom: ITHouseScale(40), right: ITHouseScale(10)))
        }
        
        loginStatusLabel.snp.makeConstraints { (make) in
            make.left.equalTo(ITHouseScale(10))
            make.bottom.equalToSuperview()
            make.top.equalTo(self.textView.snp.bottom)
            make.width.equalTo(ITHouseScale(60))
        }
        
        confirmBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-ITHouseScale(10))
            make.bottom.equalToSuperview()
            make.size.equalTo(self.loginStatusLabel)
        }
    }
    
    @objc fileprivate func confirmBtnClick() {
        textView.resignFirstResponder()
        if delegate != nil {
            delegate?.clickConfirmBtn!(withText: textView.text)
        }
    }
}
