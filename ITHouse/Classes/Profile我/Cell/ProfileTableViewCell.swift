//
//  ProfileTableViewCell.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/3/7.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    ///模型
    var model: ProfileModel? {
        didSet {
            titleLabel.text = model?.title
            contentLabel.text = model?.content
        }
    }
    
    ///图片
    fileprivate lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.lightGrayColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ITHouseScale(10)
        return view
    }()
    
    ///标题
    fileprivate lazy var titleLabel: UILabel = {
        let lb = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.blackTextColor, alignment: .left)
        return lb
    }()
    
    ///内容
    fileprivate lazy var contentLabel: UILabel = {
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        
        contentView.addSubview(lineView)
    }
    
    override func layoutSubviews() {
        imgView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: ITHouseScale(20), height: ITHouseScale(20)))
            make.left.equalTo(ITHouseScale(15))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imgView.snp.right).offset(ITHouseScale(15))
            make.centerY.equalTo(self.imgView)
            make.size.equalTo(CGSize(width: ITHouseScale(150), height: ITHouseScale(15)))
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-ITHouseScale(15))
            make.centerY.size.equalTo(self.titleLabel)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel)
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
