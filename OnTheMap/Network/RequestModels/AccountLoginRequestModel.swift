//
//  AccountLoginRequestModel.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/4/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation

struct AccountLoginRequestModel: Codable {
    
    // MARK: Properties
    
    let username: String
    let password: String
    
    // MARK: Keys
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
    
}
