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

    ///circlePublishTypeViewHeight
    fileprivate let circlePublishTypeViewHeight = ITHouseScale(50)
    
    ///CirclePublishTypeView
    fileprivate lazy var circlePublishTypeView: CirclePublishTypeView = {
        let view = CirclePublishTypeView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: circlePublishTypeViewHeight))
        view.delegate = self
        
        //设置按钮默认标题
        let title = (self.circleModel?.publishType?.first ?? "") + " > " + (self.circleModel?.publishTypeDescription?.first?.first ?? "")
        view.titleBtn.setTitle(title, for: .normal)
        
        return view
    }()
    
    ///CirclePublishTypeAlertView
    fileprivate var circlePublishTypeAlertView: CirclePublishTypeAlertView?
    
    ///标题输入框
    fileprivate lazy var titleInputTF: UITextField = {
        let tf = UITextField(frame: CGRect(x: ITHouseScale(15), y: circlePublishTypeView.frame.maxY, width: SCREEN_WIDTH-ITHouseScale(15*2), height: ITHouseScale(40)))
        tf.delegate = self
        tf.addTarget(self, action: #selector(textEditing(_:)), for: .editingChanged)
        tf.placeholder = "标题"
        return tf
    }()
    
    ///正文输入框
    fileprivate lazy var textInputTV: UITextView = {
        let tf = UITextView(frame: CGRect(x: ITHouseScale(15), y: titleInputTF.frame.maxY, width: SCREEN_WIDTH-ITHouseScale(15)*2, height: CONTENT_HEIGHT-circlePublishTypeViewHeight-ITHouseScale(60)))
        tf.delegate = self
        tf.font = UIFont.titleFont
        return tf
    }()
    
    ///占位文字
    fileprivate lazy var placeholderLabel: UILabel = {
        let label = UILabel(title: "请填写正文", titleFont: UIFont.titleFont, titleColor: UIColor.grayTextColor, alignment: .left)
        label.frame = CGRect(x: 0, y: 8, width: textInputTV.bounds.size.width, height: ITHouseScale(13))
        return label
    }()
    
    ///CircleModel
    @objc var circleModel: CircleModel?
    
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
        view.addSubview(titleInputTF)
        view.addSubview(textInputTV)
        textInputTV.addSubview(placeholderLabel)
    }
    
    //MARK: - function
    
    @objc fileprivate func back() {
        
        circlePublishTypeAlertView?.hide()
        titleInputTF.resignFirstResponder()
        textInputTV.resignFirstResponder()
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func publish() {
        DLog("发表")
        
        circlePublishTypeAlertView?.hide()
        titleInputTF.resignFirstResponder()
        textInputTV.resignFirstResponder()
    }
    
    @objc fileprivate func textEditing(_ textField: UITextField) {
        DLog(textField.text)
    }
}

extension CirclePublishViewController: CirclePublishTypeViewDelegate {
    
    func clickButton(titleBtn: UIButton, isSelected: Bool) {
        
        view.endEditing(true)
        
        if isSelected {
            
            circlePublishTypeAlertView = CirclePublishTypeAlertView(frame: CGRect(x: 0, y: circlePublishTypeView.frame.maxY+STATUSBAR_HEIGHT+NAVIGATIONBAR_HEIGHT, width: SCREEN_WIDTH, height: CONTENT_HEIGHT-circlePublishTypeViewHeight))
            circlePublishTypeAlertView?.circleModel = self.circleModel
            
            circlePublishTypeAlertView?.block = { title in//更新按钮文字
                titleBtn.setTitle(title, for: .normal)
                titleBtn.isSelected = !titleBtn.isSelected
                UIView.animate(withDuration: 0.25) {
                    titleBtn.imageView?.transform = CGAffineTransform.identity
                }
            }
            
            circlePublishTypeAlertView?.show()
            
        } else {
            circlePublishTypeAlertView?.hide()
        }
        
    }
    
}

extension CirclePublishViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension CirclePublishViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = textView.text.count > 0
    }
    
}
