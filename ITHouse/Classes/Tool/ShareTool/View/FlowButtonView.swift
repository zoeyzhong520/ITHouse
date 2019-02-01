//
//  FlowButtonView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/7.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

@objc protocol FlowButtonViewDelegate: NSObjectProtocol {
    @objc optional
    func didClick(withIndex index: Int)
}

///点击流动效果按钮
class FlowButtonView: UIView {

    weak var delegate: FlowButtonViewDelegate?
    
    ///选择的按钮
    fileprivate var selectBtn: UIButton!
    ///按钮宽度
    fileprivate var btnWidth: CGFloat = 0
    
    ///流动view
    fileprivate lazy var flowView: UILabel = {
        let view = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.white, alignment: .center)
        view.backgroundColor = UIColor.mainColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = bounds.size.height/2
        return view
    }()
    
    ///按钮名称数组
    fileprivate var btnNames = [String]()
    
    init(frame: CGRect, btnNames: [String]) {
        super.init(frame: frame)
        self.btnNames = btnNames
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addViews() {
        btnWidth = bounds.size.width/CGFloat(btnNames.count)
        let btnHeight = bounds.size.height
        
        for i in 0..<btnNames.count {
            let btn = UIButton(title: btnNames[i], titleColor: UIColor.blackTextColor, font: UIFont.titleFont, target: self, action: #selector(btnClick(_:)))
            btn.backgroundColor = UIColor.lightGrayColor
            btn.tag = i
            btn.frame = CGRect(x: btnWidth*CGFloat(i), y: 0, width: btnWidth, height: btnHeight)
            addSubview(btn)
            
            if i == 0 {
                selectBtn = btn
            }
        }
        
        addSubview(flowView)
        flowView.text = btnNames.first
        flowView.snp.makeConstraints { (make) in
            make.size.centerY.equalTo(self.selectBtn)
            make.left.equalToSuperview()
        }
    }
    
    @objc fileprivate func btnClick(_ button: UIButton) {
        selectBtn = button
        flowView.text = btnNames[button.tag]//赋值
        
        //设置flowView的位置
        UIView.animate(withDuration: 0.25) {
            self.flowView.transform = CGAffineTransform.identity.translatedBy(x: self.btnWidth*CGFloat(button.tag), y: 0)
        }
        
        if delegate != nil {
            delegate?.didClick!(withIndex: button.tag)
        }
    }

}
