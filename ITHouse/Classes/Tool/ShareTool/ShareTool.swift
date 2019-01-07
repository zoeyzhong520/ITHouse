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
    
    ///cancelBtn 宽度
    fileprivate let cancelBtnWidth = ITHouseScale(40)
    ///取消按钮
    fileprivate lazy var cancelBtn: UIButton = {
        let view = UIButton(title: "取消", titleColor: UIColor.blackTextColor, font: UIFont.textFont, target: self, action: #selector(cancelBtnClick))
        view.backgroundColor = UIColor.lightGrayColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cancelBtnWidth/2
        return view
    }()
    
    ///flowBtnsView 链接分享+图片分享
    fileprivate lazy var flowBtnsView: UIView = {
        let view = UIView()
        view.backgroundColor = RandomColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cancelBtnWidth/2
        return view
    }()
    
    ///contentViewHeight 高度
    fileprivate var contentViewHeight = ITHouseScale(250)
    ///contentView
    fileprivate var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addViews() {
        frame = SCREEN_RECT
        backgroundColor = RGBA(0,0,0,0.4)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        
        if contentView == nil {
            contentView = UIView()
            contentView?.backgroundColor = UIColor.white
            contentView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnContentView)))
            addSubview(contentView!)
            contentView?.snp.makeConstraints({ (make) in
                make.top.equalTo(self.snp.bottom)
                make.left.right.equalToSuperview()
                make.height.equalTo(self.contentViewHeight)
            })
            
            configContentView()
        }
    }
    
    fileprivate func configContentView() {
        contentView?.addSubview(cancelBtn)
        contentView?.addSubview(flowBtnsView)
        
        cancelBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-ITHouseScale(20))
            make.left.equalTo(ITHouseScale(30))
            make.size.equalTo(CGSize(width: ITHouseScale(100), height: self.cancelBtnWidth))
        }
        
        flowBtnsView.snp.makeConstraints { (make) in
            make.right.equalTo(-ITHouseScale(30))
            make.size.equalTo(CGSize(width: ITHouseScale(100*2), height: self.cancelBtnWidth))
            make.centerY.equalTo(self.cancelBtn)
        }
    }

    //MARK: - function
    
    ///show in window
    func show() {
        alpha = 0
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 1
            if let window = UIApplication.shared.delegate?.window {
                window?.addSubview(self)
            }
            self.contentView?.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -self.contentViewHeight)
        }, completion: nil)
    }
    
    ///hide from window
    @objc fileprivate func hide() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 0
            self.contentView?.transform = CGAffineTransform.identity
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    @objc fileprivate func cancelBtnClick() {
        hide()
    }
    
    @objc fileprivate func tapOnContentView() {
        //不做操作
    }
}
