//
//  TimeTransferTool.swift
//  ITHouse
//
//  Created by zhifu360 on 2018/12/29.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

///时间转黄工具
class TimeTransferTool: NSObject {
    
    ///获得当前日期
    static func nowDateString(withDateFormat dateFormat: String) -> String {
        let df = DateFormatter()
        df.dateFormat = dateFormat
        let str = df.string(from: Date())
        DLog(str)
        return str
    }
}
