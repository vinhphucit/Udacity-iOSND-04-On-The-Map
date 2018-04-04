//
//  NetworkConstants.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/3/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation

struct NetworkConstants {
    struct HTTPHeaderField {
        static let accept = "Accept"
        static let contentType = "Content-Type"
    }
    
    struct HTTPHeaderFieldValue {
        static let json = "application/json"
    }
    
    struct Udacity {
        static let APIScheme = "https"
        static let APIHost = "www.udacity.com"
        static let APIPath = "/api"
    }
    
    
    struct UdacityMethods {
        static let Authentication = "/session"
        static let Users = "/users"
    }
    
    struct Parse {
        static let APIScheme = "https"
        static let APIHost = "parse.udacity.com"
        static let APIPath = "/parse"
    }
    
    struct ParseMethods {
        static let StudentLocation = "/classes/StudentLocation"
    }
    
}
