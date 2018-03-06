//
//  CMWelcomeVC.swift
//  CloudMusic
//
//  Created by liqunfei on 2018/3/6.
//  Copyright © 2018年 LQF. All rights reserved.
//

import UIKit

class CMWelcomeVC: CMBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.orange
    }

    func buildUI() {
        
        if let notFirstStart = UserDefaults.standard.object(forKey: UserDefaultsKeys.notFirstStart.rawValue) {
            if notFirstStart is Bool {
                
                if notFirstStart as! Bool == true {
                    
                }
                else {
                    let guideView = CMGuideView()
                    self.view.addSubview(guideView)
                }
                
            }
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
