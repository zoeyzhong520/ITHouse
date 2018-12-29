//
//  SearchToolViewController.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/12/29.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class SearchToolViewController: BaseViewController {

    ///搜索框
    fileprivate lazy var searchBar: UISearchBar = {
        let bar = UISearchBar(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: NAVIGATIONBAR_HEIGHT))
        bar.barStyle = .default
        bar.showsCancelButton = true
        bar.becomeFirstResponder()
        bar.delegate = self
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
    }

    fileprivate func setPage() {
        addBarButtonItem(position: .Left, image: UIImage(), action: #selector(scanAction))
        navigationItem.titleView = searchBar
    }
    
    @objc fileprivate func scanAction() {
        
    }
}

extension SearchToolViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DLog(searchText)
        //开始搜索
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        //开始搜索
    }
}
