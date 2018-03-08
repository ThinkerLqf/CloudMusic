//
//  CMFindMusicVC.swift
//  CloudMusic
//
//  Created by liqunfei on 2018/3/6.
//  Copyright © 2018年 LQF. All rights reserved.
//

import UIKit

class CMFindMusicVC: CMBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.buildUI()
    }
    
    func buildUI() {
        
        self.view.addSubview(customNavBar)
        
    }

    // MARK:- lazy
    
    lazy var customNavBar: CMFindNavBar = {
        let navBar = CMFindNavBar(frame: CGRect(x: 0, y: 0, width: kScreen_Width, height: 64))
        navBar.backgroundColor = Theme_Red
        return navBar
    }()
    
    // MARK:- Touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
