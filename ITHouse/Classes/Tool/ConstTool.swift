//
//  ConstTool.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

///屏幕尺寸
let SCREEN_RECT = UIScreen.main.bounds
///屏幕宽度
let SCREEN_WIDTH = SCREEN_RECT.size.width
///屏幕高度
let SCREEN_HEIGHT = SCREEN_RECT.size.height
///导航栏高度
let NAVIGATIONBAR_HEIGHT = CGFloat(44.0)
///状态栏高度
let STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height
///不包含导航栏的内容尺寸
let CONTENT_HEIGHT = SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT

//MARK: - 判断设备
///是否iPad设备
let IS_IPAD = UIUserInterfaceIdiom(rawValue: 0) == UIUserInterfaceIdiom.pad
///是否iPhone设备
let IS_IPHONE = UIUserInterfaceIdiom(rawValue: 0) == UIUserInterfaceIdiom.phone
///是否Retina屏幕
let IS_RETINA = UIScreen.main.scale >= 2.0
///屏幕最大长度
let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
///屏幕最小长度
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)

//MARK: - 判断机型
///是否iPhone4s
let iPhone4s = IS_IPHONE && SCREEN_MAX_LENGTH < 568.0
///是否iPhoneSE
let iPhoneSE = IS_IPHONE && SCREEN_MAX_LENGTH == 568.0
///是否iPhone7
let iPhone7 = IS_IPHONE && SCREEN_MAX_LENGTH == 667.0
///是否iPhone7P
let iPhone7P = IS_IPHONE && SCREEN_MAX_LENGTH == 736.0
///是否iPhoneXs
let iPhoneXs = IS_IPHONE && SCREEN_MAX_LENGTH == 812.0
///是否iPhoneXR
let iPhoneXR = IS_IPHONE && SCREEN_MAX_LENGTH == 896.0
///是否iPhoneXsMax
let iPhoneXsMax = IS_IPHONE && SCREEN_MAX_LENGTH == 896.0
///Tab栏高度
let TAB_HEIGHT = iPhoneXs || iPhoneXR || iPhoneXsMax ? CGFloat(83.0) : CGFloat(49.0)


//MARK: - 适配尺寸
///适配比例
let ITHouseScale: (CGFloat) -> CGFloat = { scale in
    return (UIApplication.shared.delegate as! AppDelegate).fontSizeScale(scale: scale)
}

//MARK: - 适配字体
///正常字体
let NormalFont: (CGFloat) -> UIFont = { font in
    return UIFont.systemFont(ofSize: ITHouseScale(font))
}
///加粗字体
let BoldFont: (CGFloat) -> UIFont = { font in
    return UIFont.boldSystemFont(ofSize: ITHouseScale(font))
}

//MARK: - 颜色
///RGBA颜色
let RGBA: (CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor = { r,g,b,a in
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
///RGB颜色
let RGB: (CGFloat, CGFloat, CGFloat) -> UIColor = { r,g,b in
    return RGBA(r,g,b,1.0)
}
///Hex颜色
let HexColor: (UInt32) -> UIColor = { value in
    return RGB((CGFloat((value & 0xFF0000) >> 16)),(CGFloat((value & 0xFF00) >> 8)),(CGFloat(value & 0xFF)))
}
///随机颜色
let RandomColor = RGB(CGFloat(arc4random()%256),CGFloat(arc4random()%256),CGFloat(arc4random()%256))




















