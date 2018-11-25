//
//  UIButton+Extension.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/25.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init (title: String?, titleColor: UIColor?, font: UIFont, target: Any?, action: Selector) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = font
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    convenience init (title: String?, titleColor: UIColor?, font: UIFont) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = font
    }
    
    convenience init (image: UIImage?, target: Any?, action: Selector) {
        self.init()
        setImage(image, for: .normal)
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    convenience init (image: UIImage?) {
        self.init()
        setImage(image, for: .normal)
    }
}
