//
//  NewsDetailHotReviewTypeCell.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class NewsDetailHotReviewTypeCell: UITableViewCell {

    ///IndexPath
    var indexPath: IndexPath!
    
    ///数据模型
    var model: NewsDetailHotReview? {
        didSet {
            rankingLabel.text = "\(indexPath.row+1)"
            nickImgView.kf.setImage(with: URL(string: model?.img ?? ""), placeholder: UIImage.placeholderImg)
            
            nickNameLabel.text = model?.nickName
            //更新宽度
            nickNameLabel.snp.makeConstraints { (make) in
                make.width.equalTo(model?.nickNameLabelWidth ?? 0)
            }
            
            introductionLabel.text = model?.introduction
            
            deviceLabel.text = model?.device
            //更新宽度
            deviceLabel.snp.makeConstraints { (make) in
                make.width.equalTo(model?.deviceLabelWidth ?? 0)
            }
            
            commentLabel.text = model?.comment
            commentLabel.addLineSpacing(lineSpacing: 5)
            
            newsTitleLabel.text = model?.newsTitle
            newsTitleLabel.addLineSpacing(lineSpacing: 5)
            
            createTimeLabel.text = model?.createTime
            
            standByLabel.text = "支持(\(model?.standBy ?? ""))"
            //更新宽度
            standByLabel.snp.makeConstraints { (make) in
                make.width.equalTo(model?.standByLabelWidth ?? 0)
            }
            
            opposeLabel.text = "反对(\(model?.oppose ?? ""))"
            opposeLabel.snp.makeConstraints { (make) in
                //更新宽度
                make.width.equalTo(model?.opposeLabelWidth ?? 0)
            }
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
        label.numberOfLines = 0
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
        label.backgroundColor = UIColor.gray
        return label
    }()
    ///分享按钮
    fileprivate lazy var shareBtn: UIButton = {
        let btn = UIButton(title: "分享", titleColor: UIColor.grayTextColor, font: UIFont.textFont, target: self, action: #selector(shareBtnClick(_:)))
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
            make.topMargin.equalTo(rankingLabel)
            make.size.equalTo(CGSize(width: ITHouseScale(30), height: ITHouseScale(30)))
        }
        
        nickNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nickImgView.snp.right).offset(ITHouseScale(10))
            make.topMargin.equalTo(nickImgView)
            make.height.equalTo(ITHouseScale(13))
        }
        
        deviceLabel.snp.makeConstraints { (make) in
            make.height.equalTo(ITHouseScale(13))
            make.centerY.equalTo(nickNameLabel)
            make.left.equalTo(nickNameLabel.snp.right).offset(ITHouseScale(10))
        }
        
        introductionLabel.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(nickNameLabel)
            make.right.equalTo(-ITHouseScale(10))
            make.top.equalTo(nickImgView.snp.bottom)
            make.height.equalTo(ITHouseScale(11))
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(nickImgView)
            make.top.equalTo(introductionLabel.snp.bottom).offset(ITHouseScale(10))
            make.right.equalTo(-ITHouseScale(10))
        }
        
        newsTitleLabel.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(commentLabel)
            make.top.equalTo(commentLabel.snp.bottom).offset(ITHouseScale(10))
            make.right.equalTo(-ITHouseScale(10))
        }
        
        createTimeLabel.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(newsTitleLabel)
            make.top.equalTo(newsTitleLabel.snp.bottom).offset(ITHouseScale(10))
            make.size.equalTo(CGSize(width: SCREEN_WIDTH/4, height: ITHouseScale(11)))
        }
        
        shareBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-ITHouseScale(10))
            make.size.equalTo(CGSize(width: ITHouseScale(30), height: ITHouseScale(30)))
            make.centerY.equalTo(createTimeLabel)
        }
        
        opposeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(shareBtn.snp.left).offset(-ITHouseScale(20))
            make.height.equalTo(ITHouseScale(11))
            make.centerY.equalTo(shareBtn)
        }
        
        standByLabel.snp.makeConstraints { (make) in
            make.right.equalTo(opposeLabel.snp.left).offset(-ITHouseScale(10))
            make.centerY.equalTo(opposeLabel)
            make.height.equalTo(opposeLabel)
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
