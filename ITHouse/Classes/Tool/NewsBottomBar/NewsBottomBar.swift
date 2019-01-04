//
//  NewsBottomBar.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/4.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

@objc protocol NewsBottomBarDelegate: NSObjectProtocol {
    @objc optional
    func didClickBtn(withIndex index: Int)
    
    @objc optional
    func clickBackBtn()
}

///News-详情底部条
class NewsBottomBar: UIView {

    weak var delegate: NewsBottomBarDelegate?
    
    ///类型
    fileprivate var type: NewsBottomBarType?

    ///箭头按钮
    fileprivate lazy var backBtn: UIButton = {
        let view = UIButton(image: UIImage.backImg, target: self, action: #selector(back))
        view.tag = 0
        return view
    }()
    
    ///输入框宽度
    fileprivate var inputTFWidth:CGFloat = 0
    ///输入框高度
    fileprivate let inputTFHeight = ITHouseScale(30)
    ///输入框
    fileprivate lazy var inputTF: UITextField = {
        let tf = UITextField()
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = inputTFHeight/2
        tf.backgroundColor = UIColor.lightGrayColor
        tf.borderStyle = .none
        tf.placeholder = "    说两句"
        tf.textColor = UIColor.grayTextColor
        tf.font = UIFont.titleFont
        tf.inputAccessoryView = self.barInputAccessoryView
        tf.delegate = self
        tf.addTarget(self, action: #selector(textEditing), for: .editingChanged)
        return tf
    }()
    
    ///NewsBottomBarInputAccessoryView
    fileprivate lazy var barInputAccessoryView: NewsBottomBarInputAccessoryView = {
        let view = NewsBottomBarInputAccessoryView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: ITHouseScale(160)))
        view.delegate = self
        return view
    }()
    
    ///按钮背景view
    fileprivate lazy var btnsView: UIView = {
        let view = UIView()
        return view
    }()
    
    ///蒙层
    fileprivate lazy var blurView: UIView = {
        let view = UIView(frame: SCREEN_RECT)
        view.backgroundColor = RGBA(0,0,0,0.8)
        view.isHidden = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        return view
    }()
    
    init(frame: CGRect, type: NewsBottomBarType) {
        super.init(frame: frame)
        self.type = type
        inputTFWidth = type == NewsBottomBarType.Default ? ITHouseScale(120) : ITHouseScale(170)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addViews() {
        backgroundColor = UIColor.white
        addSubview(backBtn)
        addSubview(inputTF)
        addSubview(btnsView)
        if let window = UIApplication.shared.delegate?.window {
            window?.addSubview(blurView)
        }
        
        configBtnsView()
        
        //通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func layoutSubviews() {
        backBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: ITHouseScale(40), height: ITHouseScale(30)))
        }
        
        inputTF.snp.makeConstraints { (make) in
            make.left.equalTo(self.backBtn.snp.right)
            make.height.equalTo(self.inputTFHeight)
            make.width.equalTo(self.inputTFWidth)
            make.centerY.equalToSuperview()
        }
       
        btnsView.snp.makeConstraints { (make) in
            make.left.equalTo(self.inputTF.snp.right)
            make.right.top.bottom.equalToSuperview()
        }
    }
    
    ///填充btnsView
    fileprivate func configBtnsView() {
        var imagesArr = [UIImage?]()
        if type == NewsBottomBarType.Default {
            imagesArr = [UIImage.commentImg, UIImage.collectImg, UIImage.shareImg, UIImage.moreImg]
        } else if type == NewsBottomBarType.RefreshType {
            imagesArr = [UIImage.refreshImg, UIImage.downImg]
        }
        
        let btnWidth = (SCREEN_WIDTH - inputTFWidth - ITHouseScale(50)) / CGFloat(imagesArr.count)
        let btnHeight = bounds.size.height
        
        for i in 0..<imagesArr.count {
            let btn = UIButton(image: imagesArr[i], target: self, action: #selector(btnClick(_:)))
            btn.tag = i
            btn.frame = CGRect(x: CGFloat(i)*btnWidth, y: 0, width: btnWidth, height: btnHeight)
            btnsView.addSubview(btn)
        }
    }
    
    @objc fileprivate func btnClick(_ button: UIButton) {
        if type == NewsBottomBarType.Default {
            if button.tag == 1 {
                //收藏
                button.isSelected = !button.isSelected
                button.setImage(button.isSelected ? UIImage.collectedImg : UIImage.collectImg, for: .normal)
            }
        }
        
        if delegate != nil {
            delegate?.didClickBtn!(withIndex: button.tag)
        }
    }
    
    @objc fileprivate func back() {
        if delegate != nil {
            delegate?.clickBackBtn!()
        }
    }
    
    @objc fileprivate func textEditing() {
        DLog(inputTF.text)
        barInputAccessoryView.inputText = inputTF.text//赋值
    }
    
    @objc fileprivate func tap() {
        endEditing(true)
    }
}

extension NewsBottomBar {
    
    ///通知
    @objc fileprivate func keyboardWillShow() {
        blurView.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.blurView.alpha = 0.8
            self.blurView.isHidden = false
        }
    }
    
    @objc fileprivate func keyboardWillHide() {
        blurView.alpha = 0.8
        UIView.animate(withDuration: 0.25) {
            self.blurView.alpha = 0.0
            self.blurView.isHidden = true
        }
    }
}

extension NewsBottomBar {
    
    enum NewsBottomBarType: Int {
        case Default = 0//默认样式
        case RefreshType//刷新样式
    }
}

extension NewsBottomBar: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension NewsBottomBar: NewsBottomBarInputAccessoryViewDelegate {
    
    func clickConfirmBtn(withText text: String) {
        DLog("输入内容：\(text)")
        endEditing(true)
    }
}
