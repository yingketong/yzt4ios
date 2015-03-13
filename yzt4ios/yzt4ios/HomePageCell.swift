//
//  JieTableViewCell.swift
//  YiYou
//
//  Created by JasonFu on 15-1-20.
//  Copyright (c) 2015年 JasonFu. All rights reserved.
//

import UIKit

class HomePageCell: UITableViewCell {
    
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var SubTitle: UILabel!
    @IBOutlet weak var Date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}