//
//  NetworkConstants.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/3/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation

struct NetworkConstants {
    struct UdacityHeaderKeys {
        static let Accept = "Accept"
        static let ContentType = "Content-Type"
    }
    
    struct UdacityHeaderValues {
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
    
    struct ParseHeaderKeys {
        static let APIKey = "X-Parse-REST-API-Key"
        static let ApplicationID = "X-Parse-Application-Id"        
    }
    
    struct ParseHeaderValues {
        static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    }
    
    struct ParseParameterKeys {
        static let Limit = "limit"
        static let Order = "order"
    }
    struct ParseParameterValues {
        static let Limit = "100"
        static let Order = "-updatedAt"
    }
}
