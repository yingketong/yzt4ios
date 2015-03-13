//
//  ToolController.swift
//  YiYou
//
//  Created by JasonFu on 15-1-22.
//  Copyright (c) 2015年 JasonFu. All rights reserved.
//

import UIKit

class ToolController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderHeight = 0

        self.setExtraCellLineHidden(tableView)
    }
    
    //隐藏多余分割线
    func setExtraCellLineHidden(tableView:UITableView){
        var view = UIView()
        view.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = view
    }
}
