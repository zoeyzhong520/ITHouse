//
//  ProfileViewController.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    ///ProfileView
    fileprivate lazy var profileView: ProfileView = {
        let view = ProfileView(frame: CGRect(x: 0, y: systemVersion >= 11 ? -STATUSBAR_HEIGHT : 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-TAB_HEIGHT+(systemVersion >= 11 ? STATUSBAR_HEIGHT : 0)))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setPage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - function
    
    fileprivate func setPage() {
        view.addSubview(profileView)
    }
    
    
}
