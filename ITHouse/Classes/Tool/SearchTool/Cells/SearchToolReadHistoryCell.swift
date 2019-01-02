//
//  SearchToolReadHistoryCell.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/2.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

///阅读历史cell
class SearchToolReadHistoryCell: UITableViewCell {

    ///圆点
    fileprivate lazy var dot: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ITHouseScale(3/2)
        return view
    }()
    
    ///标题
    fileprivate lazy var contentLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.navTitleFont, titleColor: UIColor.blackTextColor, alignment: .left)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addViews() {
        contentView.addSubview(dot)
        contentView.addSubview(contentLabel)
    }
    
    override func layoutSubviews() {
        dot.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: ITHouseScale(3), height: ITHouseScale(3)))
            make.left.equalTo(ITHouseScale(15))
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.dot.snp.right).offset(ITHouseScale(15))
            make.right.equalTo(-ITHouseScale(15))
            make.top.bottom.equalToSuperview()
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

    func configData(content: String?) {
        contentLabel.text = content
    }
}
