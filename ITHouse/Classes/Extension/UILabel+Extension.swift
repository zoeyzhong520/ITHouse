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
    
    ///设置行间距
    func addLineSpacing(lineSpacing: CGFloat) {
        if self.text == nil {
            return
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineBreakMode = self.lineBreakMode
        paragraphStyle.alignment = self.textAlignment
        
        let attributedString = NSMutableAttributedString(string: self.text!)
        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, self.text!.count))
        self.attributedText = attributedString
    }
}
