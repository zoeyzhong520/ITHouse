//
//  CommonScrollBar.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/12/29.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

@objc protocol CommonScrollBarDelegate: NSObjectProtocol {
    @objc optional
    func didSelectWithIndex(index: Int)
}

class CommonScrollBar: UIView {

    weak var delegate: CommonScrollBarDelegate?
    
    ///下划线
    fileprivate lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainColor
        return view
    }()
    ///下划线宽度
    fileprivate let lineWidth = ITHouseScale(20)
    ///按钮数组
    fileprivate var btnNamesArray = [String]()
    ///按钮宽度
    fileprivate var btnWidth: CGFloat = 0
    ///选择的按钮
    fileprivate var selectBtn: UIButton!
    
    init(frame: CGRect, btnNames: [String]) {
        super.init(frame: frame)
        btnNamesArray = btnNames
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addViews() {
        btnWidth = SCREEN_WIDTH/CGFloat(btnNamesArray.count)
        let btnHeight = bounds.size.height
        
        for i in 0..<btnNamesArray.count {
            let btn = UIButton(title: btnNamesArray[i], titleColor: UIColor.blackTextColor, font: UIFont.navTitleFont, target: self, action: #selector(btnClick(_:)))
            btn.tag = i
            btn.frame = CGRect(x: btnWidth*CGFloat(i), y: 0, width: btnWidth, height: btnHeight)
            addSubview(btn)
            
            if i == 0 {
                btn.setTitleColor(UIColor.mainColor, for: .normal)
                selectBtn = btn
            }
        }
        
        //添加下划线
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.selectBtn)
            make.height.equalTo(ITHouseScale(3))
            make.width.equalTo(self.lineWidth)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc fileprivate func btnClick(_ button: UIButton) {
        if button != selectBtn {
            button.setTitleColor(UIColor.mainColor, for: .normal)
            selectBtn.setTitleColor(UIColor.blackTextColor, for: .normal)
        }
        
        selectBtn = button
        
        //设置下划线的位置
        UIView.animate(withDuration: 0.25) {
            self.line.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(button.tag)*self.btnWidth, y: 0)
        }
        
        //代理
        if delegate != nil {
            delegate?.didSelectWithIndex!(index: button.tag)
        }
    }
}
