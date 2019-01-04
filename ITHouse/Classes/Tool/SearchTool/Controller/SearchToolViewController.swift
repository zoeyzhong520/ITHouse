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
    fileprivate lazy var searchBar: ITHouseSearchBar = {
        let bar = ITHouseSearchBar(frame: CGRect(x: ITHouseScale(60), y: 0, width: SCREEN_WIDTH-ITHouseScale(60), height: NAVIGATIONBAR_HEIGHT))
        bar.barStyle = .default
        bar.showsCancelButton = true
        bar.placeholder = "搜索"
        bar.delegate = self
        return bar
    }()
    
    ///选项卡高度
    fileprivate let segmentedControlHeight = ITHouseScale(30)
    ///选项卡宽度
    fileprivate let segmentedControlWidth = SCREEN_WIDTH-ITHouseScale(140)
    ///选项卡
    fileprivate lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["文章","辣品","圈子"])
        control.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        control.tintColor = UIColor.mainColor
        control.selectedSegmentIndex = 0
        control.frame = CGRect(x: (SCREEN_WIDTH-segmentedControlWidth)/2, y: ITHouseScale(10), width: segmentedControlWidth, height: segmentedControlHeight)
        return control
    }()
    
    ///toolView
    fileprivate lazy var toolView: SearchToolView = {
        let view = SearchToolView(frame: CGRect(x: 0, y: segmentedControl.frame.maxY, width: SCREEN_WIDTH, height: CONTENT_HEIGHT-segmentedControlHeight))
        return view
    }()
    ///searchResultView
    fileprivate lazy var resultView: SearchResultView = {
        let view = SearchResultView(frame: CGRect(x: 0, y: segmentedControl.frame.maxY, width: SCREEN_WIDTH, height: CONTENT_HEIGHT-segmentedControlHeight))
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.addSubview(searchBar)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.removeFromSuperview()
    }
    
    fileprivate func setPage() {
        addBarButtonItem(position: .Left, image: UIImage.scanImg, action: #selector(scanAction))
        view.addSubview(segmentedControl)
        view.addSubview(toolView)
        view.addSubview(resultView)
    }
    
    fileprivate func getData() {
        ITHouseHttpTool.searchConfigData { [weak self] (model) in
            self?.toolView.model = model
        }
    }
    
    @objc fileprivate func scanAction() {//扫一扫
        showQRCode(withTitle: "扫扫看", delegate: self)
    }
    
    @objc fileprivate func segmentedValueChanged(_ segmented: UISegmentedControl) {
        
    }
}

extension SearchToolViewController: QRCodeViewControllerDelegate {
    
    func scanMessage(_ message: String, andQRCodeVC QRCodeVC: QRCodeViewController) {
        showAlert(withMessage: message) { [weak self] in
            QRCodeVC.navigationController?.popViewController(animated: true)
            self?.push(ofClassName: "BaseWebViewController", andParamDict: ["urlString": "https://www.baidu.com"])
        }
    }
}

extension SearchToolViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DLog(searchText)
        toolView.isHidden = searchText.count > 0 && !resultView.isHidden
        resultView.isHidden = !toolView.isHidden
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
        toolView.isHidden = true
        resultView.isHidden = false
        
        ITHouseHttpTool.searchResultData { [weak self] (model) in
            self?.resultView.model = model
        }
    }
}
