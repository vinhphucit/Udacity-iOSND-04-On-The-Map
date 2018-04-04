//
//  LoginRequestModel.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/4/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

struct LoginRequestModel: Codable {
    
    // MARK: Properties
    
    let udacity: AccountLoginRequestModel
    
    // MARK: Keys
    
    enum CodingKeys: String, CodingKey {
        case udacity
    }


    

}


