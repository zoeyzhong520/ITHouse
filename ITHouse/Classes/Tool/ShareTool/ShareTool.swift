//
//  ShareTool.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/4.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

@objc protocol ShareToolDelegate: NSObjectProtocol {
    @objc optional
    func selectItem(withModel model: ShareToolModel?)
}

class ShareTool: UIView {
    
    weak var delegate: ShareToolDelegate?
    
    ///cancelBtn 高度
    fileprivate let cancelBtnHeight = ITHouseScale(40)
    ///取消按钮
    fileprivate lazy var cancelBtn: UIButton = {
        let view = UIButton(title: "取消", titleColor: UIColor.blackTextColor, font: UIFont.titleFont, target: self, action: #selector(cancelBtnClick))
        view.backgroundColor = UIColor.lightGrayColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cancelBtnHeight/2
        return view
    }()
    
    ///flowBtnsViewWidth 宽度
    fileprivate let flowBtnsViewWidth = ITHouseScale(100*2)
    
    ///flowBtnsView 链接分享+图片分享
    fileprivate lazy var flowBtnsView: FlowButtonView = {
        let view = FlowButtonView(frame: CGRect(x: 0, y: 0, width: flowBtnsViewWidth, height: cancelBtnHeight), btnNames: ["链接分享","图片分享"])
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cancelBtnHeight/2
        view.delegate = self
        return view
    }()
    
    ///contentViewHeight 高度
    fileprivate var contentViewHeight = ITHouseScale(270)
    ///contentView
    fileprivate var contentView: UIView?
    
    ///collectionView 第三方菜单
    fileprivate lazy var thirdPartyCollectionView: ShareToolCollectionView = {
        let view = ShareToolCollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: ITHouseScale(100)))
        view.dataArr = [["title": "微信", "img": ""],["title": "微信朋友圈", "img": ""],["title": "微信收藏", "img": ""],["title": "QQ好友", "img": ""],["title": "QQ空间", "img": ""],["title": "TIM", "img": ""],["title": "新浪微博", "img": ""]]
        view.delegate = self
        return view
    }()
    
    ///collectionView 系统功能菜单
    fileprivate lazy var systemCollectionView: ShareToolCollectionView = {
        let view = ShareToolCollectionView(frame: CGRect(x: 0, y: thirdPartyCollectionView.frame.maxY, width: SCREEN_WIDTH, height: ITHouseScale(100)))
        view.dataArr = [["title": "系统分享", "img": ""],["title": "复制链接", "img": ""],["title": "短信", "img": ""],["title": "邮件", "img": ""]]
        view.delegate = self
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
        frame = SCREEN_RECT
        backgroundColor = RGBA(0,0,0,0.4)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        
        if contentView == nil {
            contentView = UIView()
            contentView?.backgroundColor = UIColor.white
            contentView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(contentViewTap(_:))))
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
        contentView?.addSubview(thirdPartyCollectionView)
        contentView?.addSubview(systemCollectionView)
        
        cancelBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-ITHouseScale(20))
            make.left.equalTo(ITHouseScale(20))
            make.size.equalTo(CGSize(width: ITHouseScale(100), height: self.cancelBtnHeight))
        }
        
        flowBtnsView.snp.makeConstraints { (make) in
            make.right.equalTo(-ITHouseScale(20))
            make.size.equalTo(CGSize(width: ITHouseScale(100*2), height: self.cancelBtnHeight))
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
    
    @objc fileprivate func contentViewTap(_ tap: UITapGestureRecognizer) {
        //do nothing...
        DLog(tap.view)
    }
    
}

extension ShareTool: FlowButtonViewDelegate {
    
    func didClick(withIndex index: Int) {
        
    }
}

extension ShareTool: ShareToolCollectionViewDelegate {
    
    func didSelectItem(withModel model: ShareToolModel?) {
        DLog(model?.title)
        if delegate != nil {
            delegate?.selectItem!(withModel: model)
        }
        hide()
    }
}

