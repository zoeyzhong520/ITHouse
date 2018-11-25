//
//  UILabel+Extension.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/25.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(title: String?, titleFont: UIFont? = nil, titleColor: UIColor? = nil, alignment: NSTextAlignment? = nil) {
        self.init()
        text = title
        
        if let t_titleFont = titleFont {
            font = t_titleFont
        }
        
        if let t_titleColor = titleColor {
            textColor = t_titleColor
        }
        
        if let t_alignment = alignment {
            textAlignment = t_alignment
        }
    }
}
