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
            
            
        default:
            return nil
        }
    }
    
    // MARK: HTTP Method
    
    var method: HTTPMethod {
        switch self {
        case .doLogin:
            return .post
        default:
            return .get
        }
    }
    
    // MARK: Headers
    
    var headers: [String: String] {
        switch self.method {
        case .post, .put, .update:
            return [NetworkConstants.HTTPHeaderField.contentType: NetworkConstants.HTTPHeaderFieldValue.json, NetworkConstants.HTTPHeaderField.accept: NetworkConstants.HTTPHeaderFieldValue.json]
        default:
            return [:]
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
        let items = [URLQueryItem]()
        
        // most requests need the api key
        //        switch self {
        //        case .getImage:
        //            break
        //        default:
        //            items.append(URLQueryItem(name: TMDB.QueryKeys.apiKey, value: TMDB.apiKey))
        //        }
        
        // certain requests have additional query items
        switch self {
            //        case .doLogin(let email, let password):
            //            items.append(URLQueryItem(name: TMDB.QueryKeys.requestToken, value: token))
            //        case .searchMovies(let query):
            //            items.append(URLQueryItem(name: TMDB.QueryKeys.query, value: query))
            //        case .getAccount, .getFavorites, .getWatchlist,
            //             .markFavorite, .markWatchlist, .getMovieState:
            //            if let sessionID = TMDB.shared.sessionID {
            //                items.append(URLQueryItem(name: TMDB.QueryKeys.sessionID, value: sessionID))
        //            }
        default:
            break
        }
        
        return items
    }
    
    
    // MARK: Subpath
    
    var subpath: String {
        switch self {
        case .doLogin: return "/session"
        }
        return ""
    }
    
    var apisource: APISource {
        switch self {
        case .doLogin:
            return APISource.udacity
        default:
            return APISource.parse
        }
    }
    
}
