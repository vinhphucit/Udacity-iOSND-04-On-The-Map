//
//  AuthSessionModel.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/3/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation

struct AuthSessionModel: Codable {
    let account: AccountModel?
    let session: SessionModel?
}
