//
//  UITableView+Extension.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerClassOf<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.iTHouse_reuseIdentifier)
    }
    
    func registerNibOf<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.iTHouse_nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.iTHouse_reuseIdentifier)
    }
    
    func registerHeaderFooterClassOf<T: UITableViewHeaderFooterView>(_: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.iTHouse_reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.iTHouse_reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.iTHouse_nibName)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>() -> T {
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: T.iTHouse_reuseIdentifier) as? T else {
            fatalError("Could not dequeue HeaderFooter with identifier: \(T.iTHouse_reuseIdentifier)")
        }
        return view
    }
}
