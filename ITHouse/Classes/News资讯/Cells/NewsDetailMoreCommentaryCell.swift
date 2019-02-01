//
//  NewsDetailMoreCommentaryCell.swift
//  ITHouse
//
//  Created by zhifu360 on 2019/1/25.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

@objc protocol NewsDetailMoreCommentaryCellDelegate: NSObjectProtocol {
    @objc optional
    func clickBtn(withTag tag: Int, model: NewsDetailCommentary?)
}

class NewsDetailMoreCommentaryCell: UITableViewCell {
    
    weak var delegate: NewsDetailMoreCommentaryCellDelegate?
    
    ///数据模型
    var model: NewsDetailCommentary? {
        didSet {
            nickImgView.kf.setImage(with: URL(string: model?.img ?? ""), placeholder: UIImage.placeholderImg)
            
            rankingLabel.text = model?.level
            //更新宽度
            rankingLabel.snp.makeConstraints { (make) in
                make.width.equalTo(model?.levelLabelWidth ?? 0)
            }
            
            nickNameLabel.text = model?.nickName
            //更新宽度
            nickNameLabel.snp.makeConstraints { (make) in
                make.width.equalTo(model?.nickNameLabelWidth ?? 0)
            }
            
            introductionLabel.text = model?.introduction
            
            deviceLabel.text = model?.device
            //更新宽度
            deviceLabel.snp.makeConstraints { (make) in
                make.width.equalTo(model?.deviceLabelWidth ?? 0)
            }
            
            commentLabel.text = model?.comment
            commentLabel.addLineSpacing(lineSpacing: 5)
            
            subCommentBtn.setTitle("展开(\(model?.subCommentNum ?? ""))", for: .normal)
            
            standByLabel.text = "支持(\(model?.standBy ?? ""))"
            //更新宽度
            standByLabel.snp.makeConstraints { (make) in
                make.width.equalTo(model?.standByLabelWidth ?? 0)
            }
            
            opposeLabel.text = "反对(\(model?.oppose ?? ""))"
            opposeLabel.snp.makeConstraints { (make) in
                //更新宽度
                make.width.equalTo(model?.opposeLabelWidth ?? 0)
            }
        }
    }
    
    ///排名
    fileprivate lazy var rankingLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.blackTextColor, alignment: .center)
        label.backgroundColor = UIColor.lightGray
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 3
        return label
    }()
    ///头像
    fileprivate lazy var nickImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = ITHouseScale(15)
        return imgView
    }()
    ///姓名
    fileprivate lazy var nickNameLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.blackTextColor, alignment: .left)
        return label
    }()
    ///介绍
    fileprivate lazy var introductionLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.grayTextColor, alignment: .left)
        return label
    }()
    ///设备
    fileprivate lazy var deviceLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.titleFont, titleColor: UIColor.blue, alignment: .left)
        return label
    }()
    ///评论
    fileprivate lazy var commentLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.navTitleFont, titleColor: UIColor.blackTextColor, alignment: .left)
        label.numberOfLines = 0
        return label
    }()
    
    ///展开按钮
    fileprivate lazy var subCommentBtn: UIButton = {
        let view = UIButton(title: "", titleColor: UIColor.grayTextColor, font: UIFont.textFont, target: self, action: #selector(btnClick(_:)))
        view.tag = 0
        view.contentHorizontalAlignment = .left
        view.alpha = 0
        return view
    }()
    ///支持
    fileprivate lazy var standByLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.green, alignment: .left)
        return label
    }()
    ///反对
    fileprivate lazy var opposeLabel: UILabel = {
        let label = UILabel(title: "", titleFont: UIFont.textFont, titleColor: UIColor.red, alignment: .left)
        return label
    }()
    ///回复按钮
    fileprivate lazy var shareBtn: UIButton = {
        let btn = UIButton(title: "回复", titleColor: UIColor.grayTextColor, font: UIFont.textFont, target: self, action: #selector(btnClick(_:)))
        btn.tag = 1
        return btn
    }()
    
    ///baseView
    fileprivate lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = RGB(250,248,250)
        return view
    }()
    
    ///分割线
    fileprivate lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.grayTextColor
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///UI
    fileprivate func addViews() {
        contentView.addSubview(baseView)
        baseView.addSubview(rankingLabel)
        baseView.addSubview(nickImgView)
        baseView.addSubview(nickNameLabel)
        baseView.addSubview(introductionLabel)
        baseView.addSubview(deviceLabel)
        baseView.addSubview(commentLabel)
        baseView.addSubview(subCommentBtn)
        baseView.addSubview(standByLabel)
        baseView.addSubview(opposeLabel)
        baseView.addSubview(shareBtn)
        baseView.addSubview(lineView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        baseView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: ITHouseScale(55), bottom: 0, right: ITHouseScale(10)))
        }
        
        nickImgView.snp.makeConstraints { (make) in
            make.left.top.equalTo(ITHouseScale(15))
            make.size.equalTo(CGSize(width: ITHouseScale(30), height: ITHouseScale(30)))
        }
        
        rankingLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(nickImgView)
            make.top.equalTo(nickImgView.snp.bottom).offset(ITHouseScale(10))
            make.height.equalTo(ITHouseScale(15))
        }
        
        nickNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nickImgView.snp.right).offset(ITHouseScale(10))
            make.topMargin.equalTo(nickImgView)
            make.height.equalTo(ITHouseScale(13))
        }
        
        deviceLabel.snp.makeConstraints { (make) in
            make.height.equalTo(ITHouseScale(13))
            make.centerY.equalTo(nickNameLabel)
            make.left.equalTo(nickNameLabel.snp.right).offset(ITHouseScale(10))
        }
        
        introductionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nickNameLabel)
            make.right.equalTo(-ITHouseScale(10))
            make.top.equalTo(nickImgView.snp.bottom)
            make.height.equalTo(ITHouseScale(11))
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nickNameLabel)
            make.top.equalTo(introductionLabel.snp.bottom).offset(ITHouseScale(10))
            make.right.equalTo(-ITHouseScale(10))
        }
        
        subCommentBtn.snp.makeConstraints { (make) in
            make.left.equalTo(commentLabel)
            make.top.equalTo(commentLabel.snp.bottom).offset(ITHouseScale(10))
            make.size.equalTo(CGSize(width: SCREEN_WIDTH/4, height: ITHouseScale(30)))
        }
        
        shareBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-ITHouseScale(10))
            make.size.equalTo(CGSize(width: ITHouseScale(30), height: ITHouseScale(30)))
            make.centerY.equalTo(subCommentBtn)
        }
        
        opposeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(shareBtn.snp.left).offset(-ITHouseScale(20))
            make.height.equalTo(ITHouseScale(11))
            make.centerY.equalTo(shareBtn)
        }
        
        standByLabel.snp.makeConstraints { (make) in
            make.right.equalTo(opposeLabel.snp.left).offset(-ITHouseScale(10))
            make.centerY.equalTo(opposeLabel)
            make.height.equalTo(opposeLabel)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(ITHouseScale(1/2))
        }
    }
    
    @objc fileprivate func btnClick(_ button: UIButton) {
        if button.tag == 0 {
            //展开
            
        }
        
        if button.tag == 1 {
            //分享
        }
        
        if delegate != nil {
            delegate?.clickBtn!(withTag: button.tag, model: model)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

