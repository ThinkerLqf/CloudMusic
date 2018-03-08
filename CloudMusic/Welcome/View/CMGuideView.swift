//
//  CMGuideView.swift
//  CloudMusic
//
//  Created by liqunfei on 2018/3/6.
//  Copyright © 2018年 LQF. All rights reserved.
//

import UIKit

class CMGuideView: UIView {

    let bigTitles = ["个性推荐","精彩评论","精选视频"]
    let smallTitles = ["每天为你量身推荐最合口味的好音乐",
                       "4亿多条有趣的故事,听歌再不孤单",
                       "音乐热点、娱乐资讯尽收眼底"]
    // 位移的位置坐标
    var mobile1_OriRect = CGRect.zero
    var mobile1_NewRect = CGRect.zero
    var mobile2_OriRect = CGRect.zero
    var mobile2_NewRect = CGRect.zero
    var bigTitle_ShowRect = CGRect.zero
    var bigTitle_DisappearRect = CGRect.zero
    var bigTitle_AppearRect = CGRect.zero
    var smallTitle_ShowRect = CGRect.zero
    var smallTitle_DisappearRect = CGRect.zero
    var smallTitle_AppearRect = CGRect.zero
    
    /// 退出引导
    var quitGuide: (()->())?
    
    /// 当前页
    var currentPage: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(redView)
        self.addSubview(whiteView)
        self.addSubview(bigTitleLabel)
        self.addSubview(smallTitleLabel)
        self.addSubview(pageControl)
        self.addSubview(loginOrRegisterBtn)
        self.addSubview(experienceBtn)
        
        whiteView.addSubview(mobileView1)
        whiteView.addSubview(mobileView2)
        
        self.addGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- 添加手势
    func addGesture() {
        let leftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(recognizer:)))
        leftRecognizer.direction = .left
        
        let rightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(recognizer:)))
        rightRecognizer.direction = .right
        
        self.whiteView.addGestureRecognizer(leftRecognizer)
        self.whiteView.addGestureRecognizer(rightRecognizer)
    }
    
    @objc func handleSwipe(recognizer: UISwipeGestureRecognizer) {
        if recognizer.direction == .right {
            if currentPage > 0 {
                
                currentPage = currentPage - 1
                self.changeUIForRightMobile()
                
            }
        }
        else if recognizer.direction == .left {
            if currentPage < 2 {
                
                currentPage = currentPage + 1
                self.changeUIForLeftMobile()
                
            }
            else if currentPage == 2 {
                
                if self.quitGuide != nil {
                    self.quitGuide!()
                }
                
            }
        }
        
        pageControl.currentPage = currentPage
    }
    
    func changeUIForLeftMobile() {
        
        // 中间区域UI变化
        if currentPage == 1 {
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.mobileView1.frame = self.mobile1_NewRect
                
            }, completion: { (tmp) in
                
                self.mobileView2.alpha = 1
                
            })
            
        }
        else if currentPage == 2 {
            self.mobileView1.alpha = 0
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.mobileView2.frame = self.mobile2_NewRect
            })
        }
        
        // 文字变化
        UIView.animate(withDuration: 0.13, animations: {
            
            self.bigTitleLabel.frame = self.bigTitle_DisappearRect
            self.smallTitleLabel.frame = self.smallTitle_DisappearRect
            
        }, completion: { (tmp) in
            
            self.bigTitleLabel.frame = self.bigTitle_AppearRect
            self.smallTitleLabel.frame = self.smallTitle_AppearRect
            self.bigTitleLabel.text = self.bigTitles[self.currentPage]
            self.smallTitleLabel.text = self.smallTitles[self.currentPage]
            
            UIView.animate(withDuration: 0.12, animations: {
                
                self.bigTitleLabel.frame = self.bigTitle_ShowRect
                self.smallTitleLabel.frame = self.smallTitle_ShowRect
                
            })
            
        })
    }
    
    func changeUIForRightMobile() {
        
        // 中间区域UI变化
        if currentPage == 0 {
            
            self.mobileView2.alpha = 0
            
            UIView.animate(withDuration: 0.25, animations: {
                self.mobileView1.frame = self.mobile1_OriRect
            })
            
        }
        else if currentPage == 1 {
            
            UIView.animate(withDuration: 0.25, animations: {
                self.mobileView1.alpha = 1
                
                self.mobileView1.frame = self.mobile1_NewRect
                self.mobileView2.frame = self.mobile2_OriRect
            })
            
        }
        
        // 文字变化
        UIView.animate(withDuration: 0.13, animations: {
            
            self.bigTitleLabel.frame = self.bigTitle_AppearRect
            self.smallTitleLabel.frame = self.smallTitle_AppearRect
            
        }, completion: { (tmp) in
            
            self.bigTitleLabel.frame = self.bigTitle_DisappearRect
            self.smallTitleLabel.frame = self.smallTitle_DisappearRect
            self.bigTitleLabel.text = self.bigTitles[self.currentPage]
            self.smallTitleLabel.text = self.smallTitles[self.currentPage]
            
            UIView.animate(withDuration: 0.12, animations: {
                
                self.bigTitleLabel.frame = self.bigTitle_ShowRect
                self.smallTitleLabel.frame = self.smallTitle_ShowRect
                
            })
            
        })
    }
    
    // MARK: - Button Action
    @objc func quitGuideAction() {
        if self.quitGuide != nil {
            self.quitGuide!()
        }
    }
    
    // MARK: - lazy
    
    lazy var experienceBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        
        var rect = loginOrRegisterBtn.frame
        rect.origin.x = rect.origin.x + rect.maxX
        button.frame = rect
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = rect.height/2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(r: 205, g: 50, b: 43, alpha: 1).cgColor
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor(r: 205, g: 50, b: 43, alpha: 1), for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 15*kScreen_Scale)
        button.setTitle("立即体验", for: .normal)
        button.addTarget(self, action: #selector(quitGuideAction), for: .touchUpInside)
        
        return button
    }()
    
    lazy var loginOrRegisterBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)

        let gap = kScreen_Height - pageControl.frame.maxY
        let w = 140*kScreen_Scale
        let h = 35*kScreen_Scale
        let x = (kScreen_Width - w*2)/3
        let y = pageControl.frame.maxY + gap/2 - h/2
        button.frame = CGRect(x: x, y: y, width: w, height: h)
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = h/2
        button.backgroundColor = UIColor(r: 205, g: 50, b: 43, alpha: 1)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 15*kScreen_Scale)
        button.setTitle("登录/注册", for: .normal)
        button.addTarget(self, action: #selector(quitGuideAction), for: .touchUpInside)
        
        return button
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl(frame: CGRect(x: 0, y: whiteView.frame.maxY + 15*kScreen_Scale, width: kScreen_Width, height: 10))
        pc.backgroundColor = UIColor.white
        pc.numberOfPages = 3
        pc.pageIndicatorTintColor = UIColor.lightGray
        pc.currentPageIndicatorTintColor = UIColor(r: 205, g: 50, b: 43, alpha: 1)
        pc.currentPage = 0
        return pc
    }()
    
    // 需要移动的view2
    lazy var mobileView2: UIImageView = {
        let w = self.whiteView.frame.width/7
        let imageView = UIImageView(frame: mobile2_OriRect)
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = w/2
        imageView.backgroundColor = UIColor.white
        imageView.alpha = 0
        
        return imageView
    }()
    
    // 需要移动的view1
    lazy var mobileView1: UIImageView = {
        let imageView = UIImageView(frame: mobile1_OriRect)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    lazy var smallTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0,
                                          y: bigTitleLabel.frame.maxY + 10*kScreen_Scale,
                                          width: kScreen_Width,
                                          height: 20*kScreen_Scale))
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15*kScreen_Scale)
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.alpha = 0.6
        label.text = smallTitles[0]
        
        smallTitle_ShowRect = label.frame
        smallTitle_DisappearRect = CGRect(x: -kScreen_Width,
                                     y: bigTitleLabel.frame.maxY + 10*kScreen_Scale,
                                     width: kScreen_Width,
                                     height: 20*kScreen_Scale)
        smallTitle_AppearRect = CGRect(x: kScreen_Width,
                                     y: bigTitleLabel.frame.maxY + 10*kScreen_Scale,
                                     width: kScreen_Width,
                                     height: 20*kScreen_Scale)
        
        return label
    }()
    
    lazy var bigTitleLabel: UILabel = {
        let gap = whiteView.frame.minY - 20
        let h = 40*kScreen_Scale
        let y = 20 + gap/2 - h
        let label = UILabel(frame: CGRect(x: 0, y: y, width: kScreen_Width, height: h))
        label.font = UIFont.systemFont(ofSize: 30*kScreen_Scale)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.text = bigTitles[0]
        
        bigTitle_ShowRect = label.frame
        bigTitle_DisappearRect = CGRect(x: -kScreen_Width, y: y, width: kScreen_Width, height: h)
        bigTitle_AppearRect = CGRect(x: kScreen_Width, y: y, width: kScreen_Width, height: h)
        
        return label
    }()
    
    lazy var whiteView: UIView = {
        var h = kScreen_Height*0.65
        if IS_IPHONE_X {
            h = kScreen_Height*0.55
        }
        
        let w = h*0.66
        let x = (kScreen_Width - w)/2
        let y = redView.frame.maxY - h*0.7
        let view = UIView(frame: CGRect(x: x, y: y, width: w, height: h))
        view.backgroundColor = UIColor(r: 0, g: 15, b: 28, alpha: 0.4)
        view.layer.cornerRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 3
        
        mobile1_OriRect = CGRect(x: view.frame.width/20,
                                 y: view.frame.height*0.46,
                                 width: view.frame.width*0.3,
                                 height: view.frame.width*0.3)
        mobile1_NewRect = CGRect(x: view.frame.width/20,
                                 y: 15*kScreen_Scale,
                                 width: view.frame.width*0.3,
                                 height: view.frame.width*0.3)
        mobile2_OriRect = CGRect(x: mobile1_OriRect.origin.x,
                                 y: 113*kScreen_Scale,
                                 width: view.frame.width/7,
                                 height: view.frame.width/7)
        mobile2_NewRect = CGRect(x: mobile1_OriRect.origin.x,
                                 y: 22*kScreen_Scale,
                                 width: view.frame.width/7,
                                 height: view.frame.width/7)
        
        return view
    }()
    
    lazy var redView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreen_Width, height: kScreen_Height*0.63))
        view.backgroundColor = UIColor(r: 205, g: 50, b: 43, alpha: 1)
        return view
    }()
    
}
