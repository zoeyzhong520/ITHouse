//
//  TopScrollingMenuPageViewController.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/25.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

@objc protocol TopScrollingMenuViewControllerDelegate: NSObjectProtocol {
    @objc optional
    func updateColumnsSqlite(topScrollingMenuViewController: TopScrollingMenuViewController, updateResult: Bool, dataSource: [String])
}

class TopScrollingMenuViewController: UIViewController {
    
    ///代理
    weak var delegate: TopScrollingMenuViewControllerDelegate?
    
    ///数据源（UIViewController数组）
    var dataSource = NSMutableArray()
    ///标题数组（String数组）
    var titles = [String]()
    ///副标题数组（String数组）
    var viceTitles = [String]()
    ///当前选中的索引
    private(set) var currentIndex = 0
    
    ///UIPageViewController对象
    fileprivate lazy var pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.interPageSpacing : 10])
        pageVC.delegate = self
        pageVC.dataSource = self
        return pageVC
    }()
    
    ///TopScrollingMenuSegmentView对象
    fileprivate lazy var segmentView: TopScrollingMenuSegmentView = {
        let view = TopScrollingMenuSegmentView(frame: CGRect(x: 0, y: STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT, width: SCREEN_WIDTH, height: ITHouseScale(30)))
        view.dataSource = self.titles
        view.viceDataSource = self.viceTitles
        //计算每个item的宽度
        for text in self.titles {
            view.itemWidths.append(text.textWidth(font: UIFont.navTitleFont))
        }
        view.delegate = self
        DLog("itemWidths: \(view.itemWidths)")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    ///UI
    fileprivate func createUI() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        view.addSubview(segmentView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        assert(dataSource.count > 0, "Must have one childViewController at least")
        let vc = dataSource[currentIndex] as! UIViewController
        pageViewController.setViewControllers([vc], direction: .reverse, animated: true, completion: nil)
    }
    
    func reloadData() {
        currentIndex = dataSource.count - 1//一定要设置currentIndex的值
        segmentView.selectedIndex = currentIndex
        let vc = self.dataSource.lastObject as! UIViewController
        pageViewController.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
    }
}

extension TopScrollingMenuViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = dataSource.index(of: viewController)
        if index == 0 || index == NSNotFound {
            return nil
        }
        index -= 1
        return dataSource.object(at: index) as? UIViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = dataSource.index(of: viewController)
        if index == dataSource.count - 1 || index == NSNotFound {
            return nil
        }
        index += 1
        return dataSource.object(at: index) as? UIViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let nextVC = pendingViewControllers.first else {
            fatalError("pendingViewControllers`s first object is nil")
        }
        let index = dataSource.index(of: nextVC)
        currentIndex = index
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        DLog("completed: \(completed)")
        if completed {
            //设置segmentView的item与pageViewController联动
            segmentView.selectedIndex = currentIndex
            DLog("currentIndex: \(currentIndex)")
        }
    }
}

extension TopScrollingMenuViewController:TopScrollingMenuSegmentViewDelegate {
    
    ///选中segmentView中某个item
    func segmentView(segmentView: TopScrollingMenuSegmentView, selectedIndex: Int) {
        if selectedIndex > dataSource.count - 1 {
            return
        }
        
        let vc = dataSource.object(at: selectedIndex) as! UIViewController
        if selectedIndex > currentIndex {
            pageViewController.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        } else {
            pageViewController.setViewControllers([vc], direction: .reverse, animated: true, completion: nil)
        }
        currentIndex = selectedIndex
    }
    
    func updateColumnsSqlite(segmentView: TopScrollingMenuSegmentView, updateResult: Bool, dataSource: [String]) {
        if delegate != nil {
            delegate?.updateColumnsSqlite!(topScrollingMenuViewController: self, updateResult: updateResult, dataSource: dataSource)
        }
    }
}
