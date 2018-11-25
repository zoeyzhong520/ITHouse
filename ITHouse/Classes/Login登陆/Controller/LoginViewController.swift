//
//  LoginViewController.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    ///logoImageView
    fileprivate lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.logoImg)
        return imageView
    }()
    
    ///accountTF
    fileprivate lazy var accountTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "邮箱/手机号"
        tf.font = UIFont.navTitleFont
        tf.textColor = UIColor.blackTextColor
        let leftView = UIImageView(image: UIImage.accountImg)
        leftView.frame = CGRect(x: 0, y: 0, width: ITHouseScale(16), height: ITHouseScale(16))
        tf.leftView = leftView
        tf.leftViewMode = .always
        tf.keyboardType = .namePhonePad
        tf.delegate = self
        tf.addTarget(self, action: #selector(textEditing), for: .editingChanged)
        return tf
    }()
    
    ///passwordTF
    fileprivate lazy var passwordTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "密码"
        tf.font = UIFont.navTitleFont
        tf.textColor = UIColor.blackTextColor
        tf.isSecureTextEntry = true
        let leftView = UIImageView(image: UIImage.passwordImg)
        leftView.frame = CGRect(x: 0, y: 0, width: ITHouseScale(16), height: ITHouseScale(16))
        tf.leftView = leftView
        tf.leftViewMode = .always
        tf.keyboardType = .namePhonePad
        tf.delegate = self
        tf.addTarget(self, action: #selector(textEditing), for: .editingChanged)
        return tf
    }()
    
    ///密码明文开关
    fileprivate lazy var secureEntryBtn: UIButton = {
        let btn = UIButton(image: UIImage.secureEntryImg, target: self, action: #selector(secureEntry(_:)))
        return btn
    }()
    
    ///loginBtn
    fileprivate lazy var loginBtn: UIButton = {
        let btn = UIButton(title: "登陆", titleColor: UIColor.white, font: UIFont.navTitleFont, target: self, action: #selector(login))
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = ITHouseScale(22)
        btn.backgroundColor = UIColor.grayTextColor
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: ITHouseScale(44), height: ITHouseScale(44)))
            make.top.equalTo(STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT + ITHouseScale(44))
        }
        
        accountTF.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(ITHouseScale(44))
            make.left.equalTo(ITHouseScale(44))
            make.right.equalTo(-ITHouseScale(44))
            make.height.equalTo(ITHouseScale(44))
        }
        
        passwordTF.snp.makeConstraints { (make) in
            make.top.equalTo(accountTF.snp.bottom).offset(ITHouseScale(20))
            make.left.equalTo(ITHouseScale(44))
            make.right.equalTo(-ITHouseScale(44))
            make.height.equalTo(ITHouseScale(44))
        }
        
        secureEntryBtn.snp.makeConstraints { (make) in
            make.centerY.right.equalTo(passwordTF)
            make.size.equalTo(CGSize(width: ITHouseScale(30), height: ITHouseScale(30)))
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTF.snp.bottom).offset(ITHouseScale(44))
            make.left.equalTo(ITHouseScale(44))
            make.right.equalTo(-ITHouseScale(44))
            make.height.equalTo(ITHouseScale(44))
        }
    }
    
    ///UI
    fileprivate func createUI() {
        addBarButtonItem(position: .Left, image: UIImage.backImg, action: #selector(back))
        view.addSubview(logoImageView)
        view.addSubview(accountTF)
        view.addSubview(passwordTF)
        view.addSubview(secureEntryBtn)
        view.addSubview(loginBtn)
    }

    @objc fileprivate func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func login() {
        UserDefaultsTool.setToken(token: accountTF.text! + passwordTF.text!)
    }
    
    @objc fileprivate func textEditing() {
        if let account = accountTF.text, let password = passwordTF.text {
            loginBtn.backgroundColor = account.count > 0 && password.count > 0 ? UIColor.mainColor : UIColor.grayTextColor
            loginBtn.isUserInteractionEnabled = account.count > 0 && password.count > 0 ? true : false
        } else {
            loginBtn.backgroundColor = UIColor.grayTextColor
            loginBtn.isUserInteractionEnabled = false
        }
    }
    
    @objc fileprivate func secureEntry(_ button: UIButton) {
        button.isSelected = !button.isSelected
        passwordTF.isSecureTextEntry = button.isSelected
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension LoginViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        accountTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return true
    }
}
