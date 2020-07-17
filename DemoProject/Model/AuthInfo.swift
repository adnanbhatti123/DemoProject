//
//  AuthInfo.swift
//  DemoProject
//
//  Created by APPLE on 17/07/2020.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class AuthInfo: NSObject {
    var username:String!
    var password:String!
    var accessToken:String!
    
    init(username:String,password:String,accessToken:String) {
        self.username = username
        self.password = password
        self.accessToken = accessToken
    }
}
