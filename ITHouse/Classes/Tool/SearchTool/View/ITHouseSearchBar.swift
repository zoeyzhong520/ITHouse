//
//  ITHouseSearchBar.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/2.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ITHouseSearchBar: UISearchBar {

    override func layoutSubviews() {
        super.layoutSubviews()
    
        guard let tf = subviews.first?.subviews.last as? UITextField else {
            fatalError("获取textField失败")
        }
        
        tf.frame = CGRect(x: 0, y: (NAVIGATIONBAR_HEIGHT-30)/2, width: bounds.size.width-50, height: 30)
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 15
    }

}
