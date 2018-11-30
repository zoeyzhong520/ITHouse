

//
//  NewsDetailRankingSpicyTypeCell.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/11/30.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class NewsDetailRankingSpicyTypeCell: UITableViewCell {
    
    ///indexPath
    var indexPath: IndexPath!
    
    ///数据模型
    var model: NewsDetailNewsRankingList? {
        didSet {
            imgView.kf.setImage(with: URL(string: model?.img ?? ""), placeholder: UIImage.placeholderImg)
            rankingLabel.text = "\(indexPath.row)"
            titleLabel.text = model?.title
            discountLabel.text = (model?.price ?? "") + "\(model?.sales ?? "")"
            salesLabel.text = model?.sales
            salePriceLabel.text = model?.salePrice
            couponLabel.text = model?.coupon
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
        label.layer.cornerRadius = ITHouseScale(6)
        return label
    }()
    
    ///标题
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.blackTextColor, alignment: .left)
        return label
    }()
    
    ///折扣
    fileprivate lazy var discountLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.grayTextColor, alignment: .left)
        return label
    }()
    
    ///销量
    fileprivate lazy var salesLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.grayTextColor, alignment: .right)
        return label
    }()
    
    ///售价
    fileprivate lazy var salePriceLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.mainColor, alignment: .left)
        return label
    }()
    
    ///优惠券
    fileprivate lazy var couponLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.navTitleFont, titleColor: UIColor.white, alignment: .center)
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
        // Initialization code
    }
    
    ///UI
    fileprivate func addViews() {
        contentView.addSubview(imgView)
        imgView.addSubview(rankingLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(discountLabel)
        contentView.addSubview(salesLabel)
        contentView.addSubview(salePriceLabel)
        contentView.addSubview(couponLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(ITHouseScale(15))
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: ITHouseScale(110), height: ITHouseScale(80)))
        }
        
        rankingLabel.snp.makeConstraints { (make) in
            make.left.equalTo(ITHouseScale(5))
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: ITHouseScale(12), height: ITHouseScale(12)))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(ITHouseScale(15))
            make.right.equalTo(-ITHouseScale(15))
            make.topMargin.equalTo(imgView)
        }
        
        discountLabel.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH/3, height: ITHouseScale(11)))
        }
        
        salePriceLabel.snp.makeConstraints { (make) in
            make.leftMargin.size.equalTo(discountLabel)
            make.bottomMargin.equalTo(imgView)
        }
        
        couponLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(salePriceLabel)
            make.rightMargin.equalTo(titleLabel)
            make.size.equalTo(CGSize(width: ITHouseScale(60), height: ITHouseScale(20)))
        }
        
        salesLabel.snp.makeConstraints { (make) in
            make.rightMargin.equalTo(titleLabel)
            make.size.equalTo(discountLabel)
            make.bottom.equalTo(couponLabel.snp.top)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
