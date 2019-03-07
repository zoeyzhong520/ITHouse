//
//  CircleTableViewCell.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/3/7.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class CircleTableViewCell: UITableViewCell {

    ///模型
    var model: CircleListModel? {
        didSet {
            imgView.kf.setImage(with: URL(string: model?.img ?? ""), placeholder: UIImage.placeholderImg)
            nickLabel.text = model?.nickName
            typeLabel.text = model?.type
            
            titleLabel.text = model?.title
            timeLabel.text = model?.createTime
            commentLabel.text = model?.comment
        }
    }
    
    ///头像
    fileprivate lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ITHouseScale(10)
        return view
    }()
    
    ///昵称
    fileprivate lazy var nickLabel: UILabel = {
        let lb = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.grayTextColor, alignment: .left)
        return lb
    }()
    
    ///类别
    fileprivate lazy var typeLabel: UILabel = {
        let lb = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.blackTextColor, alignment: .center)
        lb.backgroundColor = UIColor.lightGrayColor
        lb.layer.masksToBounds = true
        lb.layer.cornerRadius = ITHouseScale(10)
        return lb
    }()
    
    ///标题
    fileprivate lazy var titleLabel: UILabel = {
        let lb = UILabel(title: "", titleFont: UIFont.navTitleFont, titleColor: UIColor.blackTextColor, alignment: .left)
        return lb
    }()
    
    ///时间
    fileprivate lazy var timeLabel: UILabel = {
        let lb = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.grayTextColor, alignment: .left)
        return lb
    }()
    
    ///评论
    fileprivate lazy var commentLabel: UILabel = {
        let lb = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.grayTextColor, alignment: .right)
        return lb
    }()
    
    ///分割线
    fileprivate lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGrayColor
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - function
    
    fileprivate func addViews() {
        contentView.addSubview(imgView)
        contentView.addSubview(nickLabel)
        contentView.addSubview(typeLabel)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(commentLabel)
        
        contentView.addSubview(lineView)
    }
    
    override func layoutSubviews() {
        imgView.snp.makeConstraints { (make) in
            make.left.top.equalTo(ITHouseScale(15))
            make.size.equalTo(CGSize(width: ITHouseScale(20), height: ITHouseScale(20)))
        }
        
        nickLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imgView.snp.right).offset(ITHouseScale(10))
            make.centerY.equalTo(self.imgView)
            make.right.equalToSuperview()
            make.height.equalTo(ITHouseScale(13))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imgView)
            make.centerY.equalToSuperview()
            make.right.equalTo(-ITHouseScale(15))
            make.height.equalTo(ITHouseScale(15))
        }
        
        typeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-ITHouseScale(15))
            make.centerY.equalTo(self.nickLabel)
            make.size.equalTo(CGSize(width: ITHouseScale(40), height: ITHouseScale(20)))
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imgView)
            make.bottom.equalTo(-ITHouseScale(15))
            make.size.equalTo(CGSize(width: SCREEN_WIDTH/2, height: ITHouseScale(11)))
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.typeLabel)
            make.centerY.equalTo(self.timeLabel)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH/2, height: ITHouseScale(11)))
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self.imgView)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(1)
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
