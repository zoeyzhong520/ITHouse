//
//  UICollectionView+Extension.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerClassOf<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.iTHouse_reuseIdentifier)
    }
    
    func registerNibOf<T: UICollectionViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.iTHouse_nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.iTHouse_reuseIdentifier)
    }
    
    func registerHeaderClassOf<T: UICollectionReusableView>(_: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.iTHouse_reuseIdentifier)
    }
    
    func registerHeaderNibOf<T: UICollectionReusableView>(_: T.Type) {
        let nib = UINib(nibName: T.iTHouse_nibName, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.iTHouse_reuseIdentifier)
    }
    
    func registerFooterClassOf<T: UICollectionReusableView>(_: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.iTHouse_reuseIdentifier)
    }
    
    func registerFooterNibOf<T: UICollectionReusableView>(_: T.Type) {
        let nib = UINib(nibName: T.iTHouse_nibName, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.iTHouse_reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.iTHouse_reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.iTHouse_reuseIdentifier)")
        }
        return cell
    }
    
    func dequeuereusableSupplymentaryView<T: UICollectionReusableView>(ofKind kind: String, forIndexPath indexPath: IndexPath) -> T {
        guard let view = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.iTHouse_reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue supplementary view with identifier: \(T.iTHouse_reuseIdentifier) kind: \(kind)")
        }
        return view
    }
}
