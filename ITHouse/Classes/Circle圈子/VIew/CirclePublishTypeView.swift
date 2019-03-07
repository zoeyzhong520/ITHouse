//
//  CirclePublishTypeView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/2/1.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

@objc protocol CirclePublishTypeViewDelegate: NSObjectProtocol {
    @objc optional
    func clickButton(titleBtn: UIButton, isSelected: Bool)
}

class CirclePublishTypeView: UIView {
    
    weak var delegate: CirclePublishTypeViewDelegate?
    
    ///标题按钮
    lazy var titleBtn: UIButton = {
        let btn = UIButton(title: "", titleColor: UIColor.mainColor, font: UIFont.navTitleFont, target: self, action: #selector(btnClick(_:)))
        btn.tintColor = UIColor.mainColor
        btn.setImage(UIImage.downArrowImg?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: ITHouseScale(4), left: -ITHouseScale(4), bottom: ITHouseScale(4), right: 0)
        btn.imageView?.tintColor = UIColor.mainColor
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    
    ///分割线
    fileprivate lazy var lineView: UIView = {
        let view = UIView()
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
    
    fileprivate func addViews() {
        addSubview(titleBtn)
        addSubview(lineView)
    }

    override func layoutSubviews() {
        titleBtn.snp.makeConstraints { (make) in
            make.left.equalTo(ITHouseScale(15))
            make.right.equalTo(-ITHouseScale(15))
            make.top.bottom.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    //MARK: - function
    
    @objc fileprivate func btnClick(_ button: UIButton) {
        button.isSelected = !button.isSelected
        
        if button.isSelected {
            UIView.animate(withDuration: 0.25) {
                button.imageView?.transform = CGAffineTransform.identity.rotated(by: CGFloat(Double.pi))
            }
        } else {
            UIView.animate(withDuration: 0.25) {
                button.imageView?.transform = CGAffineTransform.identity
            }
        }
        
        //代理
        if delegate != nil {
            delegate?.clickButton!(titleBtn: button, isSelected: button.isSelected)
        }
        
    }
}
