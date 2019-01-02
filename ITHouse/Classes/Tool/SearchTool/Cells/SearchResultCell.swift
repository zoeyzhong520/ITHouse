//
//  SearchResultCell.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/2.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

///搜索结果cell
class SearchResultCell: UITableViewCell {

    ///数据模型
    var model: SearchResultListModel? {
        didSet {
            titleLabel.text = model?.title
            timeLabel.text = model?.createTime
        }
    }
    
    ///标题
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.navTitleFont, titleColor: UIColor.blackTextColor, alignment: .left)
        return label
    }()
    ///时间
    fileprivate lazy var timeLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.blackTextColor, alignment: .left)
        return label
    }()
    ///分割线
    fileprivate lazy var line: UIView = {
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
    
    fileprivate func addViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(line)
    }
    
    override func layoutSubviews() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(ITHouseScale(15))
            make.right.equalTo(-ITHouseScale(15))
            make.height.equalTo(ITHouseScale(15))
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.bottom.equalTo(-ITHouseScale(15))
            make.height.equalTo(ITHouseScale(11))
        }
        
        line.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.bottom.equalToSuperview()
            make.height.equalTo(ITHouseScale(1))
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
