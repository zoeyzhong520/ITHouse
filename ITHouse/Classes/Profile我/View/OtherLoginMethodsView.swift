//
//  OtherLoginMethodsView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/3/7.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

@objc protocol OtherLoginMethodsViewDelegate: NSObjectProtocol {
    
    @objc optional
    func selectWithIndex(index: Int)
}

class OtherLoginMethodsView: UIView {

    weak var delegate: OtherLoginMethodsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - function
    
    fileprivate func addViews() {
        
        let imagesArray = ["","","",""]
        let btnMargin = ITHouseScale(50)
        let btnWidth = (bounds.size.width - btnMargin*CGFloat(imagesArray.count-1)) / CGFloat(imagesArray.count)
        
        for i in 0..<imagesArray.count {
            let btn = UIButton(image: UIImage(named: imagesArray[i]), target: self, action: #selector(btnClickAction(_:)))
            btn.frame = CGRect(x: CGFloat(i)*(btnWidth+btnMargin), y: ITHouseScale(15), width: btnWidth, height: btnWidth)
            btn.tag = i
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = btnWidth / 2
            btn.backgroundColor = RandomColor
            addSubview(btn)
        }
    }
    
    @objc fileprivate func btnClickAction(_ button: UIButton) {
        if delegate != nil {
            delegate?.selectWithIndex!(index: button.tag)
        }
    }
    
}
