//
//  TopScrollingMenuSegmentView.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/25.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

@objc protocol TopScrollingMenuSegmentViewDelegate: NSObjectProtocol {
    @objc optional
    ///选择某一个item
    func segmentView(segmentView: TopScrollingMenuSegmentView, selectedIndex: Int)
}

class TopScrollingMenuSegmentView: UIView {

    ///数据源（String数组）
    var dataSource = [String]()
    ///存储item宽度数组
    var itemWidths = [CGFloat]()
    ///代理
    weak var delegate: TopScrollingMenuSegmentViewDelegate?
    
    ///选项卡最右端的肩头view
    fileprivate lazy var coverView: UIButton = {
        let view = UIButton()
        view.isSelected = true
        view.addTarget(self, action: #selector(coverViewClick(_:)), for: .touchUpInside)
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "downArrowImg"))
        view.addSubview(imageView)
        coverImageView = imageView
        imageView.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 18, height: 18))
        })
        return view
    }()
    
    ///箭头ImageView
    fileprivate var coverImageView: UIImageView!
    
    ///选中的索引
    var selectedIndex: Int? {
        didSet {
            if selectedIndex != nil && selectedIndex! < dataSource.count {
                reloadItems(selectedIndex: selectedIndex!)
            }
        }
    }
    
    ///存储选中indexPath的字典
    fileprivate var indexPathsDict = NSMutableDictionary()
    ///CollectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width - self.bounds.size.height, height: self.bounds.size.height), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.registerClassOf(TopScrollingMenuSegmentCell.self)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///UI
    fileprivate func createUI() {
        addSubview(collectionView)
        addSubview(coverView)
        //默认选中第一个item
        indexPathsDict.setObject(true, forKey: "\(0)" as NSCopying)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coverView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(self.bounds.size.height)
        }
    }
    
    ///更新item的选中状态
    fileprivate func reloadItems(selectedIndex: Int) {
        indexPathsDict.setObject(true, forKey: "\(selectedIndex)" as NSCopying)
        
        for key in indexPathsDict.allKeys {
            //判断字典中key是否存在，并更新字典
            let t_key = key as! String
            if t_key != "\(selectedIndex)" {
                indexPathsDict.setObject(false, forKey: t_key as NSCopying)
            }
        }
        
        //设置点击item滚动
        if selectedIndex < dataSource.count - 1 {
            collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
        
        //刷新
        collectionView.reloadData()
    }
    
    @objc fileprivate func coverViewClick(_ button: UIButton) {
        button.isSelected = !button.isSelected
        //旋转箭头图标
        self.coverImageView.transform = !button.isSelected ? CGAffineTransform.identity : CGAffineTransform.identity.rotated(by: -CGFloat(Double.pi))
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseInOut, animations: {
            self.coverImageView.transform = !button.isSelected ? CGAffineTransform.identity.rotated(by: -CGFloat(Double.pi)) : CGAffineTransform.identity
        }) { (finished) in
            let columnView = TopScrollingMenuColumnView()
            columnView.show()
        }
    }
}

extension TopScrollingMenuSegmentView:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:TopScrollingMenuSegmentCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.text = dataSource[indexPath.row]
        cell.isItemSelected = indexPathsDict.object(forKey: "\(indexPath.row)") as? Bool
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //更新item的选中状态
        reloadItems(selectedIndex: indexPath.row)
        
        //代理方法
        if delegate != nil {
            delegate?.segmentView!(segmentView: self, selectedIndex: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemWidths[indexPath.row], height: bounds.size.height)
    }
}
