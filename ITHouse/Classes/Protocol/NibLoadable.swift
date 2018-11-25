//
//  NibLoadable.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

protocol NibLoadable {
    static var iTHouse_nibName: String { get }
}

extension UITableViewCell: NibLoadable {
    static var iTHouse_nibName: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: NibLoadable {
    static var iTHouse_nibName: String {
        return String(describing: self)
    }
}
