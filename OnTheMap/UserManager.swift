//
//  UserManager.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/5/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation

struct UserManager {
    var locations = [StudentInformation]()
    var session:AuthSessionModel?
    var user:UserInfoModel?
    static var shared = UserManager()
}
