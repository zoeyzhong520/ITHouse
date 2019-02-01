//
//  CirclePublishTypeView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/2/1.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class CirclePublishTypeView: UIView {

    ///标题按钮
    lazy var titleBtn: UIButton = {
        let btn = UIButton(title: "", titleColor: UIColor.mainColor, font: UIFont.navTitleFont, target: self, action: #selector(btnClick(_:)))
        btn.tintColor = UIColor.mainColor
        btn.setImage(UIImage.downArrowImg, for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -ITHouseScale(20), bottom: 0, right: 0)
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
            make.left.right.equalTo(self.titleBtn)
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
        
    }
}
