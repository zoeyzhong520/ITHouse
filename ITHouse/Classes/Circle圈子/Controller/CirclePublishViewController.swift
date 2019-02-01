//
//  CirclePublishViewController.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/2/1.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

///发表新帖
class CirclePublishViewController: BaseViewController {

    ///circlePublishTypeView
    fileprivate let circlePublishTypeViewHeight = ITHouseScale(50)
    
    ///CirclePublishTypeView
    fileprivate lazy var circlePublishTypeView: CirclePublishTypeView = {
        let view = CirclePublishTypeView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: circlePublishTypeViewHeight))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        addViews()
        
    }
    
    fileprivate func setNavigation() {
        title = "发表新帖"
        
        addBarButtonItem(position: .Left, title: "取消", action: #selector(back), tintColor: UIColor.blackTextColor)
        addBarButtonItem(position: .Right, title: "发表", action: #selector(publish), tintColor: UIColor.blackTextColor)
    }
    
    fileprivate func addViews() {
        view.addSubview(circlePublishTypeView)
    }

    //MARK: - function
    
    @objc fileprivate func back() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func publish() {
        DLog("发表")
    }
}
