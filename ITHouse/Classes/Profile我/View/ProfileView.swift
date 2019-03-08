//
//  ProfileView.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/3/7.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    ///tbView
    fileprivate lazy var tableView: UITableView = {
        let tbView = UITableView(frame: bounds, style: .grouped)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.registerClassOf(ProfileTableViewCell.self)
        return tbView
    }()
    
    ///tableHeaderView
    fileprivate lazy var tableHeaderView: ProfileTableHeaderView = {
        let view = ProfileTableHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: ProfileTableHeaderView.getViewHeight()))
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - function
    
    fileprivate func addViews() {
        addSubview(tableView)
        tableView.tableHeaderView = self.tableHeaderView
    }

}

extension ProfileView: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileModel.getArray().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = ProfileModel.getArray()[section]
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProfileTableViewCell = tableView.dequeueReusableCell()
        cell.model = ProfileModel.getArray()[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
