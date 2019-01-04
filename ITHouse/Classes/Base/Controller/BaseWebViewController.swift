//
//  BaseWebViewController.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/3.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit
import SVProgressHUD

///web视图
class BaseWebViewController: BaseViewController {

    ///webView
    fileprivate lazy var webView: UIWebView = {
        let view = UIWebView(frame: self.view.bounds)
        view.delegate = self
        return view
    }()
    
    ///链接
    @objc var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
    
    fileprivate func setPage() {
        view.addSubview(webView)
        
        if urlString != nil {
            if urlString!.contains("http") {//网址
                webView.loadRequest(URLRequest(url: URL(string: urlString!)!))
            } else {//h5代码
                webView.loadHTMLString(urlString!, baseURL: nil)
            }
        }
    }
    
}

extension BaseWebViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
        DLog(error.localizedDescription)
    }
}
