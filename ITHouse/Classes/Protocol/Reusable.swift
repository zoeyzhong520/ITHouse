//
//  Reusable.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var iTHouse_reuseIdentifier: String { get }
}

extension UITableViewCell: Reusable {
    static var iTHouse_reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: Reusable {
    static var iTHouse_reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: Reusable {
    static var iTHouse_reuseIdentifier: String {
        return String(describing: self)
    }
}

