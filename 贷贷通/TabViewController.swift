//
//  TabViewController.swift
//  贷贷通
//
//  Created by iMac on 16/3/2.
//  Copyright © 2016年 wujunbao. All rights reserved.
//
var tabbarController : TabViewController!
import UIKit

class TabViewController: UITabBarController{

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "首页"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        print("tab bar item 被点击")
        switch item.tag{
        case 0:
            self.navigationItem.title = "首页"
        case 1:
            self.navigationItem.title = "产品"
        case 2:
            self.navigationItem.title = "账户"
        case 3:
            self.navigationItem.title = "更多"
        default:
            print("weizhi")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
