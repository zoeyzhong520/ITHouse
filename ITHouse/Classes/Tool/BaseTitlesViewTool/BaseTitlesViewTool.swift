//
//  BaseTitlesViewTool.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/2/25.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class BaseTitlesViewTool: UIView {

    ///selectedButton
    fileprivate var selectedButton: UIButton!
    
    ///下划线
    fileprivate lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainColor
        return view
        
    }()
    
    ///buttonsArray
    fileprivate var buttonsArray = [UIButton]()
    
    ///buttonNameArray
    fileprivate var buttonNameArray = [String]()
    
    ///btnWidth
    fileprivate var btnWidth: CGFloat = 0
    
    ///currentSelectIndex
    var currentSelectIndex: Int = 0
    
    init(frame: CGRect, buttonNameArray: [String]) {
        super.init(frame: frame)
        
        self.buttonNameArray = buttonNameArray
        addViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addViews() {
        
        backgroundColor = UIColor.white
        
        btnWidth = bounds.size.width / CGFloat(buttonNameArray.count)
        let btnHeight = bounds.size.height
        
        for i in 0..<buttonNameArray.count {
            let button = UIButton(title: buttonNameArray[i], titleColor: UIColor.blackTextColor, font: UIFont.titleFont, target: self, action: #selector(btnClick(_:)))
            button.frame = CGRect(x: CGFloat(i)*btnWidth, y: 0, width: btnWidth, height: btnHeight)
            button.tag = i
            addSubview(button)
            
            //默认选中第一个按钮
            if i == 0 {
                button.setTitleColor(UIColor.mainColor, for: .normal)
                selectedButton = button
            }
            
        }
        
        //设置下划线
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.selectedButton)
            make.size.equalTo(CGSize(width: ITHouseScale(15), height: ITHouseScale(2)))
            make.bottom.equalToSuperview()
        }
        
    }
    
    //MARK: - function
    
    @objc fileprivate func btnClick(_ button: UIButton) {
        
        if selectedButton != button {
            selectedButton.setTitleColor(UIColor.blackTextColor, for: .normal)
            button.setTitleColor(UIColor.mainColor, for: .normal)
        }
        
        selectedButton = button
        
        //设置下划线位移
        UIView.animate(withDuration: 0.25) {
            self.lineView.transform = CGAffineTransform(translationX: self.btnWidth*CGFloat(button.tag), y: 0)
        }
        
    }

}
