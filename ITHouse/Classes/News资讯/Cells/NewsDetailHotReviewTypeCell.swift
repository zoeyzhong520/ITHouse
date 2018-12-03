//
//  NewsDetailHotReviewTypeCell.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class NewsDetailHotReviewTypeCell: UITableViewCell {

    ///数据模型
    var model: NewsDetailHotReview? {
        didSet {
            
        }
    }
    
    ///排名
    fileprivate lazy var rankingLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.white, alignment: .center)
        label.backgroundColor = RGBA(0,0,0,0.4)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = ITHouseScale(12)
        return label
    }()
    ///头像
    fileprivate lazy var nickImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = ITHouseScale(15)
        return imgView
    }()
    ///姓名
    fileprivate lazy var nickNameLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.blackTextColor, alignment: .left)
        return label
    }()
    ///介绍
    fileprivate lazy var introductionLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.grayTextColor, alignment: .left)
        return label
    }()
    ///设备
    fileprivate lazy var deviceLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.blue, alignment: .left)
        return label
    }()
    ///评论
    fileprivate lazy var commentLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.navTitleFont, titleColor: UIColor.blackTextColor, alignment: .left)
        label.numberOfLines = 0
        return label
    }()
    ///原文标题
    fileprivate lazy var newsTitleLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.blue, alignment: .left)
        return label
    }()
    ///时间
    fileprivate lazy var createTimeLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.grayTextColor, alignment: .left)
        return label
    }()
    ///支持
    fileprivate lazy var standByLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.green, alignment: .left)
        return label
    }()
    ///反对
    fileprivate lazy var opposeLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.red, alignment: .left)
        return label
    }()
    ///分享按钮
    fileprivate lazy var shareBtn: UIButton = {
        let btn = UIButton(title: "", titleColor: UIColor.grayTextColor, font: UIFont.textFont, target: self, action: #selector(shareBtnClick(_:)))
        return btn
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
        contentView.addSubview(rankingLabel)
        contentView.addSubview(nickImgView)
        contentView.addSubview(nickNameLabel)
        contentView.addSubview(introductionLabel)
        contentView.addSubview(deviceLabel)
        contentView.addSubview(commentLabel)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(createTimeLabel)
        contentView.addSubview(standByLabel)
        contentView.addSubview(opposeLabel)
        contentView.addSubview(shareBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rankingLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(ITHouseScale(15))
            make.size.equalTo(CGSize(width: ITHouseScale(24), height: ITHouseScale(24)))
        }
        
        nickImgView.snp.makeConstraints { (make) in
            make.left.equalTo(rankingLabel.snp.right).offset(ITHouseScale(15))
            make.centerY.equalTo(rankingLabel)
            make.size.equalTo(CGSize(width: ITHouseScale(30), height: ITHouseScale(30)))
        }
        
        nickNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nickImgView.snp.right).offset(ITHouseScale(10))
            make.topMargin.equalTo(nickImgView)
            make.size.equalTo(CGSize(width: 20, height: ITHouseScale(13)))
        }
        
        deviceLabel.snp.makeConstraints { (make) in
            make.centerY.size.equalTo(nickNameLabel)
            make.left.equalTo(nickNameLabel.snp.right).offset(ITHouseScale(15))
        }
        
        introductionLabel.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(nickImgView)
            
        }
    }
    
    @objc fileprivate func shareBtnClick(_ button: UIButton) {
        
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
