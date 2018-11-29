//
//  TopScrollingMenuSegmentCell.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/25.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class TopScrollingMenuSegmentCell: UICollectionViewCell {
    
    ///标题
    var text: String? {
        didSet {
            textLabel.text = text
        }
    }
    
    ///是否选中
    var isItemSelected: Bool? {
        didSet {
            textLabel.textColor = isItemSelected == true ? UIColor.mainColor : UIColor.blackTextColor
            self.bottomLine.isHidden = self.isItemSelected == true ? false : true
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
                self.bottomLine.alpha = self.isItemSelected == true ? 1.0 : 0.0
            }) { (finished) in
                
            }
        }
    }
    
    ///标题label
    fileprivate lazy var textLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.navTitleFont, titleColor: UIColor.blackTextColor, alignment: .center)
        return label
    }()
    
    ///bottomLine
    fileprivate lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///UI
    fileprivate func createUI() {
        contentView.addSubview(textLabel)
        contentView.addSubview(bottomLine)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.centerX.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: self.bounds.size.width/3, height: ITHouseScale(3)))
        }
    }
}
