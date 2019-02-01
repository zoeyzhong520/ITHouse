//
//  NewsDetailViewController.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/4.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

///newsBottomBarHeight
public let newsBottomBarHeight = ITHouseScale(50)

///News-详情
class NewsDetailViewController: BaseViewController {
    
    ///webView
    fileprivate lazy var webView: WKWebView = {
        let view = WKWebView(frame: CGRect(x: 0, y: STATUSBAR_HEIGHT, width: self.view.bounds.size.width, height: self.view.bounds.size.height-STATUSBAR_HEIGHT-newsBottomBarHeight), configuration: WKWebViewConfiguration())
        view.navigationDelegate = self
        return view
    }()
    ///链接
    fileprivate let urlString = "https://www.taobao.com"
    
    ///newsBottomBar
    fileprivate lazy var newsBottomBar: NewsBottomBar = {
        let bar = NewsBottomBar(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: newsBottomBarHeight), type: NewsBottomBar.NewsBottomBarType.Default)
        bar.delegate = self
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        SVProgressHUD.dismiss()
    }
    
    fileprivate func setPage() {
        view.addSubview(webView)
        webView.load(URLRequest(url: URL(string: urlString)!))
        
        view.addSubview(newsBottomBar)
    }
    
    override func viewWillLayoutSubviews() {
        newsBottomBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(newsBottomBarHeight)
        }
    }
}

extension NewsDetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.dismiss()
        DLog(error.localizedDescription)
    }
}

extension NewsDetailViewController: NewsBottomBarDelegate {
    
    func clickBackBtn() {
        navigationController?.popViewController(animated: true)
    }
    
    func didClickBtn(withIndex index: Int) {
        if index == 0 {
            //查看评论
            push(ofClassName: "NewsDetailCommentaryViewController")
        }
        
        if index == 2 {
            //分享
            ShareTool(frame: .zero).show()
        }
    }
}
