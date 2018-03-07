//
//  CMExtension.swift
//  CloudMusic
//
//  Created by liqunfei on 2018/3/7.
//  Copyright © 2018年 LQF. All rights reserved.
//

import UIKit

class CMExtension: NSObject {

}

extension UIColor {
    // 便利初始化方法
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
}
