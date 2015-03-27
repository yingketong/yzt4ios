//
//  AppController.swift
//  yzt4ios
//
//  Created by JasonFu on 15-3-24.
//  Copyright (c) 2015年 JasonFu. All rights reserved.
//

import UIKit

class AppController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad();
        let result = NetworkUtil.httpGet("http://10.87.66.223:8080/appServer/model/kpi/list.json?limit=6&start=0&page=1&orgId=2",params: nil)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showApp" {
                let object : NSString = "http://211.95.5.70/cr/project/index"
                (segue.destinationViewController as AppWebController).object = object
        }
    }
}