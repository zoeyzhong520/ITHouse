//
//  DebugPrintTool.swift
//  ITHouse
//
//  Created by 仲召俊 on 2018/11/24.
//  Copyright © 2018 ZZJ. All rights reserved.
//

import UIKit

func DLog<T>(_ item: T) {
    #if DEBUG
    print("File: \((#file as NSString).lastPathComponent) Line: \(#line) Item: \(item)")
    #endif
}
