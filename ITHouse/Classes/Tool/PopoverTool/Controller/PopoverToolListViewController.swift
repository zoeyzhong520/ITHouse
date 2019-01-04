//
//  PopoverToolListViewController.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/4.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

@objc protocol PopoverToolListViewControllerDelegate: NSObjectProtocol {
    @objc optional
    func didSelectItem(withIndex index: Int)
}

///Popover视图
class PopoverToolListViewController: UIViewController {

    weak var delegate: PopoverToolListViewControllerDelegate?
    
    ///数据源
    var dataSource = [String]()
    ///箭头锚点
    var anchorBarBtnItem: UIBarButtonItem? {
        didSet {
            preferredContentSize = CGSize(width: 150, height: 50*dataSource.count)
            modalPresentationStyle = .popover
            popoverPresentationController?.barButtonItem = anchorBarBtnItem
            popoverPresentationController?.permittedArrowDirections = .up
            popoverPresentationController?.delegate = self
        }
    }
    ///cellID
    fileprivate let cellID = "cellID"
    ///tbView
    fileprivate lazy var tableView: UITableView = {
        let tbView = UITableView(frame: view.bounds, style: .plain)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tbView.rowHeight = 50
        tbView.isScrollEnabled = false
        return tbView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
    }
    
    fileprivate func setPage() {
        view.addSubview(tableView)
    }
}

extension PopoverToolListViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = dataSource[indexPath.row]
        cell?.textLabel?.textColor = UIColor.black
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
        //代理
        if delegate != nil {
            delegate?.didSelectItem!(withIndex: indexPath.row)
        }
    }
}

extension PopoverToolListViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
