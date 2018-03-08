//
//  CMFindNavBar.swift
//  CloudMusic
//
//  Created by liqunfei on 2018/3/8.
//  Copyright © 2018年 LQF. All rights reserved.
//

import UIKit

class CMFindNavBar: UIView {

    /// 子视图相关
    let subH = 30*kScreen_Scale
    let subY = 20 + (40 - 30*kScreen_Scale)/2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(discernBtn)
        self.addSubview(playBtn)
        self.addSubview(searchBar)
        self.addSubview(cancelBtn)
    }
    
    // MARK:改变UI
    
    @objc func cancelAction() {
        
        self.searchBar.normalStateUI()
        
        self.normalStateUI()
        
    }
    
    fileprivate func editingStateUI() {
        
        var cancelRect = self.cancelBtn.frame
        cancelRect.origin.x = cancelRect.origin.x - 52*kScreen_Scale
        
        UIView.animate(withDuration: 0.25, animations: {
            self.discernBtn.alpha = 0
            self.playBtn.alpha = 0
            self.cancelBtn.frame = cancelRect
        })
        
    }
    
    fileprivate func normalStateUI() {
        
        var cancelRect = self.cancelBtn.frame
        cancelRect.origin.x = kScreen_Width
        
        UIView.animate(withDuration: 0.25, animations: {
            self.discernBtn.alpha = 1
            self.playBtn.alpha = 1
            self.cancelBtn.frame = cancelRect
        })
        
    }
    
    // MARK: lazy
    
    lazy var cancelBtn: UIButton = {
        let button = UIButton(type: .custom)
        
        button.frame = CGRect(x: kScreen_Width, y: subY, width: 52*kScreen_Scale, height: subH)
        button.setTitle("取消", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16*kScreen_Scale)
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        return button
    }()
    
    /// 搜索框
    lazy var searchBar: CMSearchBar = {
        let bar = CMSearchBar(frame: CGRect(x: 52*kScreen_Scale,
                                            y: subY,
                                            width: kScreen_Width - 2*52*kScreen_Scale,
                                            height: subH))
        bar.stretchRect = CGRect(x: 20*kScreen_Scale,
                                 y: subY,
                                 width: kScreen_Width - (20 + 52)*kScreen_Scale,
                                 height: subH)
        
        bar.beginEditing = {
            
            self.editingStateUI()
            
        }
        
        bar.endEditing = {
            
            self.normalStateUI()
            
        }
        
        return bar
    }()
    
    /// 播放
    lazy var playBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: kScreen_Width - (16 + 20)*kScreen_Scale,
                              y: subY,
                              width: 20*kScreen_Scale,
                              height: subH)
        button.backgroundColor = UIColor.white
        return button
    }()
    
    /// 识歌
    lazy var discernBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.frame = CGRect(x: 16*kScreen_Scale,
                              y: subY,
                              width: 20*kScreen_Scale,
                              height: subH)
        button.backgroundColor = UIColor.white
        return button
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CMSearchBar: UIView {
    
    /// 拉伸后的坐标
    var stretchRect = CGRect.zero {
        willSet {
            self.logo_StretchRect = CGRect(x: 20,
                                           y: 5*kScreen_Scale,
                                           width: 15*kScreen_Scale,
                                           height: 20*kScreen_Scale)
            let tf_NewX = self.logo_StretchRect.maxX + 10
            
            self.tf_StretchRect = CGRect(x: tf_NewX, y: 0, width: newValue.width - tf_NewX - 20, height: newValue.height)
        }
    }
    /// 初始位置
    var originRect = CGRect.zero
    
    var logo_OriginRect = CGRect.zero
    var logo_StretchRect = CGRect.zero
    
    var tf_OriginRect = CGRect.zero
    var tf_StretchRect = CGRect.zero
    
    /// 开始编辑
    var beginEditing: (()->())?
    /// 结束编辑
    var endEditing: (()->())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.originRect = frame
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = frame.height/2
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(textField)
        self.addSubview(logo)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:UI动画
    fileprivate func editingStateUI() {
        UIView.animate(withDuration: 0.25) {
            
            self.frame = self.stretchRect
            self.logo.frame = self.logo_StretchRect
            self.textField.frame = self.tf_StretchRect
            
        }
    }
    
    fileprivate func normalStateUI() {
        
        self.textField.resignFirstResponder()
        
        UIView.animate(withDuration: 0.25) {
            
            self.frame = self.originRect
            self.logo.frame = self.logo_OriginRect
            self.textField.frame = self.tf_OriginRect
            
        }
    }
    
    // MARK:lazy
    lazy var logo: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: self.textField.frame.minX - 15*kScreen_Scale - 10,
                                                  y: 5*kScreen_Scale,
                                                  width: 15*kScreen_Scale,
                                                  height: 20*kScreen_Scale))
        
        self.logo_OriginRect = imageView.frame
        
        imageView.backgroundColor = UIColor(r: 42, g: 16, b: 0, alpha: 0.5)
        return imageView
    }()
    
    /// 输入框
    lazy var textField: UITextField = {
        
        let text = "搜索音乐、视频、电台"
        
        let rect = CMFunctionTool.sizeWithText(text: text,
                                               font: UIFont.systemFont(ofSize: 16*kScreen_Scale),
                                               size: CGSize(width: self.frame.width - 15*kScreen_Scale,
                                                            height: self.frame.height))
        
        let w = rect.width
        
        let tf = UITextField(frame: CGRect(x: (self.frame.width - w)/2,
                                           y: 0,
                                           width: w,
                                           height: self.frame.height))
        self.tf_OriginRect = tf.frame
        
        tf.placeholder = text
        tf.font = UIFont.systemFont(ofSize: 16*kScreen_Scale)
        tf.textColor = UIColor.black
        tf.tintColor = Theme_Red
        tf.delegate = self
        tf.clearButtonMode = .whileEditing
        tf.returnKeyType = .search
        return tf
    }()
    
}

extension CMSearchBar: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if self.beginEditing != nil {
            self.beginEditing!()
        }
        
        self.editingStateUI()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.text = ""
        
        if self.endEditing != nil {
            self.endEditing!()
        }
        
        self.normalStateUI()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text != nil ? textField.text! : "没有输入内容")
        return true
    }
    
}
