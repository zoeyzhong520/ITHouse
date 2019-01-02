//
//  SearchToolHotCell.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/2.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

///热门搜索cell
class SearchToolHotCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addViews() {
        
    }
    
    func configData(btnNames: [String]?) {
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        
        guard let btnNamesArr = btnNames else {
            fatalError("btnNames is nil")
        }
        
        let btnHeight = ITHouseScale(30)
        let btnMargin = ITHouseScale(10)
        let btnWidth = (SCREEN_WIDTH-(btnMargin*6))/5
        
        for i in 0..<btnNamesArr.count {
            let btn = UIButton(title: btnNamesArr[i], titleColor: UIColor.blackTextColor, font: UIFont.textFont, target: self, action: #selector(btnClick(_:)))
            btn.tag = i
            btn.backgroundColor = UIColor.lightGrayColor
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = btnHeight/2
            btn.frame = CGRect(x: CGFloat(i%5)*(btnMargin+btnWidth)+btnMargin, y: CGFloat(i/5)*(btnHeight+btnMargin)+btnMargin, width: btnWidth, height: btnHeight)
            contentView.addSubview(btn)
        }
    }
    
    @objc fileprivate func btnClick(_ button: UIButton) {
        
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
