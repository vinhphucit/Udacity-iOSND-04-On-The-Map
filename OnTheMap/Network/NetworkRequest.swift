//
//  NetworkConstants.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/2/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case update = "UPDATE"
    case delete = "DELETE"
}

enum APISource {
    case udacity
    case parse
}

enum APIRequest {
    case doLogin(email: String, password: String)
    case doLoadUserInfo()
    case doLogout(session: String)
    case getStudenLocations()
    case doPostAStudenLocation(student: StudentInformation)
    // MARK: URL Request
    
    var urlRequest: URLRequest? {
        var request: URLRequest?
        
        if let url = components.url {
            var urlRequest = URLRequest(url: url)
            
            // add method
            urlRequest.httpMethod = method.rawValue
            
            // add headers
            for (key, value) in headers { urlRequest.addValue(value, forHTTPHeaderField: key) }
            
            // add http body
            if let httpBody = httpBody { urlRequest.httpBody = httpBody }
            
            request = urlRequest
        }
        
        return request
    }
    
    // MARK: HTTP body
    
    var httpBody: Data? {
        switch self {
        case .doLogin(let email, let password):
            let accountLoginRequestModel = AccountLoginRequestModel(username: email, password: password)
            let loginRequestModel = LoginRequestModel(udacity: accountLoginRequestModel)
            do {
                let encoder = JSONEncoder()
                let data =  try encoder.encode(loginRequestModel)
                return data
            } catch {
                return nil
            }
            
        case .doPostAStudenLocation(let student):
            do {
                let encoder = JSONEncoder()
                let data =  try encoder.encode(student)
                return data
            } catch {
                return nil
            }
        default:
            return nil
        }
    }
    
    // MARK: HTTP Method
    
    var method: HTTPMethod {
        switch self {
        case .doLogin, .doPostAStudenLocation:
            return .post
        case .doLogout:
            return .delete
        default:
            return .get
        }
    }
    
    // MARK: Headers
    
    var headers: [String: String] {
        switch self.apisource {
        case .udacity:
            switch self.method {
            case .post, .put, .update:
                return [NetworkConstants.UdacityHeaderKeys.ContentType: NetworkConstants.UdacityHeaderValues.json, NetworkConstants.UdacityHeaderKeys.Accept: NetworkConstants.UdacityHeaderValues.json]
            case .delete:
                switch self {
                case .doLogout(let session):
                    return ["XSRF-TOKEN":session]
                default:
                    return [:]
                }
            default:
                return [:]
            }
        default:
            return [NetworkConstants.ParseHeaderKeys.APIKey: NetworkConstants.ParseHeaderValues.APIKey, NetworkConstants.ParseHeaderKeys.ApplicationID: NetworkConstants.ParseHeaderValues.ApplicationID,
            NetworkConstants.UdacityHeaderKeys.ContentType: NetworkConstants.UdacityHeaderValues.json]
        }
        
    }
    
    // MARK: Components
    
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = self.apisource == .udacity ? NetworkConstants.Udacity.APIScheme : NetworkConstants.Parse.APIScheme
        components.host = hostAndPath.0
        components.path = hostAndPath.1
        components.queryItems = queryItems
        
        return components
    }
    
    
    // MARK: Host and Path
    
    private var hostAndPath: (String, String) {
        switch self.apisource {
        case .udacity:
            return (NetworkConstants.Udacity.APIHost, NetworkConstants.Udacity.APIPath + subpath)
        default:
            return (NetworkConstants.Parse.APIHost, NetworkConstants.Parse.APIPath + subpath)
        }
    }
    
    
    // MARK: Query Items
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        
        switch self {
        case .getStudenLocations:
            items.append(URLQueryItem(name: NetworkConstants.ParseParameterKeys.Limit, value: NetworkConstants.ParseParameterValues.Limit))
            items.append(URLQueryItem(name: NetworkConstants.ParseParameterKeys.Order, value: NetworkConstants.ParseParameterValues.Order))
        default:
            break
        }
        
        return items
    }
    
    
    // MARK: Subpath
    
    var subpath: String {
        switch self {
        case .doLogin, .doLogout:
            return NetworkConstants.UdacityMethods.Authentication
        case .doLoadUserInfo:
            return "\(NetworkConstants.UdacityMethods.Users)/\((UserManager.shared.session?.account?.key)!)"
        case .getStudenLocations:
            return NetworkConstants.ParseMethods.StudentLocation
        case .doPostAStudenLocation(let student):
            return NetworkConstants.ParseMethods.StudentLocation
        }
    }
    
    var apisource: APISource {
        switch self {
        case .doLogin, .doLogout, .doLoadUserInfo:
            return APISource.udacity
        default:
            return APISource.parse
        }
    }
    
}
