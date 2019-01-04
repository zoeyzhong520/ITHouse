//
//  NewsDetailPhotoTextTypeCell.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

///图文cell（三图）
class NewsDetailPhotoTextTypeCell: UITableViewCell {

    ///数据模型
    var model: NewsDetailNewsPhotoText? {
        didSet {
            titleLabel.text = model?.title
            titleLabel.addLineSpacing(lineSpacing: 5)
            timeLabel.text = model?.createTime
            commentLabel.text = (model?.commentNum ?? "") + "评"
            createImagesView()
        }
    }
    
    ///标题
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.navTitleFont, titleColor: UIColor.blackTextColor, alignment: .left)
        label.numberOfLines = 0
        return label
    }()
    
    ///时间
    fileprivate lazy var timeLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.grayTextColor, alignment: .left)
        return label
    }()
    
    ///评论
    fileprivate lazy var commentLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.grayTextColor, alignment: .right)
        return label
    }()
    
    ///图片们
    fileprivate lazy var imagesView: UIView = {
        return UIView()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///UI
    fileprivate func addViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(commentLabel)
        contentView.addSubview(imagesView)
    }
    
    ///设置imagesView
    fileprivate func createImagesView() {
        for view in imagesView.subviews {
            view.removeFromSuperview()
        }
        
        if let images = model?.images {
            let imgMargin = ITHouseScale(15)
            let imgWidth = (SCREEN_WIDTH - imgMargin*CGFloat(images.count+1))/CGFloat(images.count)
            let imgHeight = ITHouseScale(80)
            
            for i in 0..<images.count {
                let imgView = UIImageView()
                imgView.kf.setImage(with: URL(string: images[i]), placeholder: UIImage.placeholderImg)
                imgView.frame = CGRect(x: CGFloat(i)*(imgWidth+imgMargin)+imgMargin, y: 0, width: imgWidth, height: imgHeight)
                imgView.layer.masksToBounds = true
                imgView.layer.cornerRadius = ITHouseScale(4)
                imagesView.addSubview(imgView)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(ITHouseScale(15))
            make.right.equalTo(-ITHouseScale(15))
            make.top.equalTo(ITHouseScale(10))
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(titleLabel)
            make.bottom.equalTo(-ITHouseScale(10))
            make.size.equalTo(CGSize(width: SCREEN_WIDTH/3, height: ITHouseScale(11)))
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.rightMargin.equalTo(titleLabel)
            make.centerY.size.equalTo(timeLabel)
        }
        
        imagesView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(ITHouseScale(10))
            make.left.right.equalToSuperview()
            make.height.equalTo(ITHouseScale(80))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
