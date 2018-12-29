//
//  NewsCalendarView.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/12/29.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class NewsCalendarView: UIView {

    ///滚动视图
    fileprivate lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: bounds)
        view.isPagingEnabled = true
        view.contentSize = CGSize(width: SCREEN_WIDTH*4, height: 0)
        view.contentOffset = CGPoint(x: 0, y: 0)
        return view
    }()
    
    ///view
    fileprivate lazy var view: UIView = {
        let view = UIView()
        return view
    }()
    
    
}
