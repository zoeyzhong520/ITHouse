//
//  BorderShownCardsCell.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class BorderShownCardsCell: UICollectionViewCell {
    
    ///数据源（String）
    var imageUrl: String? {
        didSet {
            if imageUrl?.contains("http") == true {
                imgView.kf.setImage(with: URL(string: imageUrl ?? ""), placeholder: UIImage.placeholderImg)
            } else {
                imgView.image = UIImage(named: imageUrl ?? "")
            }
        }
    }
    
    ///imgView
    fileprivate lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///UI
    fileprivate func addViews() {
        contentView.addSubview(imgView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
