

//
//  NewsDetailRankingTypeCell.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class NewsDetailRankingTypeCell: UITableViewCell {
    
    ///indexPath
    var indexPath: IndexPath!
    
    ///数据模型
    var model: NewsDetailNewsRankingList? {
        didSet {
            imgView.kf.setImage(with: URL(string: model?.img ?? ""), placeholder: UIImage.placeholderImg)
            rankingLabel.text = "\(indexPath.row)"
            titleLabel.text = model?.title
            timeLabel.text = model?.createTime
            commentLabel.text = (model?.commentNum ?? "") + "评"
        }
    }
    
    ///图片
    fileprivate lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = ITHouseScale(4)
        imageView.layer.masksToBounds = true
        return imageView
    }()
    ///排名
    fileprivate lazy var rankingLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.white, alignment: .center)
        label.backgroundColor = RGBA(0,0,0,0.4)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = ITHouseScale(12)
        return label
    }()
    ///标题
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.blackTextColor, alignment: .left)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addViews()
    }
    
    ///UI
    fileprivate func addViews() {
        contentView.addSubview(imgView)
        imgView.addSubview(rankingLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(commentLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(ITHouseScale(15))
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: ITHouseScale(110), height: ITHouseScale(80)))
        }
        
        rankingLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(ITHouseScale(5))
            make.size.equalTo(CGSize(width: ITHouseScale(24), height: ITHouseScale(24)))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(ITHouseScale(15))
            make.right.equalTo(-ITHouseScale(15))
            make.topMargin.equalTo(imgView)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(titleLabel)
            make.bottomMargin.equalTo(imgView)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH/4, height: ITHouseScale(11)))
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-ITHouseScale(15))
            make.centerY.size.equalTo(timeLabel)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
