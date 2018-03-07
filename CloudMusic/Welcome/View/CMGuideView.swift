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
            print("向右滑")
        }
        else if recognizer.direction == .left {
            if currentPage < 2 {
                currentPage = currentPage + 1
                
                if currentPage == 1 {
                    
                }
                else if currentPage == 2 {
                    
                }
            }
            else if currentPage == 2 {
                
            }
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
    
    // 需要移动的view1
    lazy var mobileView1: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: whiteView.frame.width/20, y: whiteView.frame.height*0.46, width: whiteView.frame.width*0.3, height: whiteView.frame.width*0.3))
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    lazy var smallTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: bigTitleLabel.frame.maxY + 10*kScreen_Scale, width: kScreen_Width, height: 20*kScreen_Scale))
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15*kScreen_Scale)
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.alpha = 0.6
        label.text = smallTitles[0]
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
        return view
    }()
    
    lazy var redView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreen_Width, height: kScreen_Height*0.63))
        view.backgroundColor = UIColor(r: 205, g: 50, b: 43, alpha: 1)
        return view
    }()
    
}
