//
//  Config.swift
//  CloudMusic
//
//  Created by liqunfei on 2018/3/7.
//  Copyright © 2018年 LQF. All rights reserved.
//

import Foundation
import UIKit

let CMUserDefaults = UserDefaults.standard

// MARK:- 屏幕尺寸
let kScreen_Width = UIScreen.main.bounds.size.width
let kScreen_Height = UIScreen.main.bounds.size.height
let kScreen_Scale = UIScreen.main.bounds.size.width/375

let IS_IPHONE_X = UIScreen.main.bounds.size.height > 736

/// 状态栏高度
let kStatusBar_Height: CGFloat = IS_IPHONE_X ? 35 : 20

/// 导航栏高度
let kNavBar_Height: CGFloat = kStatusBar_Height + 44

// MARK:- 颜色
let Theme_Red = UIColor(r: 211, g: 60, b: 51, alpha: 1)

