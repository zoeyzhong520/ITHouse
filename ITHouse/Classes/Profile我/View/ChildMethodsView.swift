//
//  ChildMethodsView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/3/7.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

@objc protocol ChildMethodsViewDelegate: NSObjectProtocol {
    
    @objc optional
    func selectWithIndex(index: Int)
}

class ChildMethodsView: UIView {
    
    weak var delegate: ChildMethodsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - function
    
    fileprivate func addViews() {
        
        let imagesArray = ["collect","collect","collect","collect"]
        let titlesArray = ["评论","帖子","收藏","足迹"]
        let btnWidth = bounds.size.width / CGFloat(imagesArray.count)
        let btnHeight = bounds.size.height
        
        for i in 0..<imagesArray.count {
            let btn = UIButton(image: UIImage(named: imagesArray[i]), target: self, action: #selector(btnClickAction(_:)))
            btn.setTitle(titlesArray[i], for: .normal)
            btn.setTitleColor(UIColor.blackTextColor, for: .normal)
            btn.titleLabel?.font = UIFont.titleFont
            btn.frame = CGRect(x: CGFloat(i)*btnWidth, y: 0, width: btnWidth, height: btnHeight)
            btn.tag = i
            
            addSubview(btn)
        }
    }
    
    @objc fileprivate func btnClickAction(_ button: UIButton) {
        if delegate != nil {
            delegate?.selectWithIndex!(index: button.tag)
        }
    }
    
}
