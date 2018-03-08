//
//  CMFunctionTool.swift
//  CloudMusic
//
//  Created by liqunfei on 2018/3/8.
//  Copyright © 2018年 LQF. All rights reserved.
//

import Foundation
import UIKit

class CMFunctionTool: NSObject {
    
    
    /// 计算字符串需要的尺寸
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - font: 字体
    ///   - size: 尺寸限制
    /// - Returns: 所需尺寸
    static func sizeWithText(text: String, font: UIFont, size: CGSize) -> CGRect {
        let attributes = [NSAttributedStringKey.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect
    }
    
}
