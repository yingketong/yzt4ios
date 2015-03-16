//
//  UserModel.swift
//  yzt4ios
//
//  Created by JasonFu on 15-3-13.
//  Copyright (c) 2015年 JasonFu. All rights reserved.
//

import Foundation

public class UserModel : NSObject{
        
    var contactId: String;
    var userName: String;
    var userCName: String;
    var mobile: String;
    
    init(contactId: String, userName: String, userCName: String, mobile: String){
        self.contactId = contactId;
        self.userName = userName;
        self.userCName = userCName;
        self.mobile = mobile;
        
        super.init();
    }
}
