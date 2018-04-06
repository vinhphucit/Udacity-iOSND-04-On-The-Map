//
//  UserInfoModel.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/6/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation

struct UserInfoModel: Codable {
    let id: String?
    let firstName: String?
    let lastName: String?
    
     enum CodingKeys: String, CodingKey {
        case id = "key"
        case lastName = "last_name"
        case firstName = "first_name"
    }
}
