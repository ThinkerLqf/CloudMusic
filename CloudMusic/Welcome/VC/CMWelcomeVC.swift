//
//  CMWelcomeVC.swift
//  CloudMusic
//
//  Created by liqunfei on 2018/3/6.
//  Copyright © 2018年 LQF. All rights reserved.
//

import UIKit
import SwiftyJSON

class CMWelcomeVC: CMBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.buildUI()
    }

    func buildUI() {
        
        let notFirstStart = CMUserDefaults.object(forKey: UserDefaultsKeys.notFirstStart.rawValue)
        
        if notFirstStart != nil {
            let nfsJson = JSON(notFirstStart!)
            if nfsJson.boolValue == true {
                // 非首次启动app
                
            }
        }
        else {
            // 首次启动app
            // 取消下面一行代码的注释就可以实现只显示一次引导页面
            // CMUserDefaults.set(true, forKey: UserDefaultsKeys.notFirstStart.rawValue)
            let guideView = CMGuideView(frame: CGRect(x: 0, y: 0, width: kScreen_Width, height: kScreen_Height))
            self.view.addSubview(guideView)
        }
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
