//
//  NetworkClient.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/2/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation

class NetworkClient: NSObject {
    
    // shared session
    var session = URLSession.shared
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    func makeRequest<T: Decodable>(_ request: APIRequest, type: T.Type, completion: @escaping (_ data: T?, _ error : String?) -> Void) -> URLSessionDataTask?{
        guard let urlRequest = request.urlRequest else { return nil}
        print(urlRequest)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            func sendError(_ error: String) {
                print(error)
                performUIUpdatesOnMain {
                    completion(nil, error)
                }
                
            }
                        
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!.localizedDescription)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                sendError("Request did not return a valid response.")
                return
            }
            
            switch (statusCode) {
            case 403:
                sendError("Please check your credentials and try again.")
            case 200 ..< 299:
                break
            default:
                sendError("Your request returned a status code other than 2xx!")
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            var newData = data
            if request.apisource == .udacity {
                let range = Range(5..<data.count)
                newData = data.subdata(in: range)
            }
            let photoObject = try? JSONDecoder().decode(type, from: newData)
            performUIUpdatesOnMain {
                completion(photoObject, nil)
            }
            print(String(data: newData, encoding: .utf8)!)
        }
        task.resume()
        return task
    }
    
    
    func doLogin(email: String, password: String, completion: @escaping (_ data: AuthSessionModel?, _ error : String?) -> Void) {
        makeRequest(.doLogin(email: email, password: password), type: AuthSessionModel.self, completion: completion)
    }
    
    
    static let shared = NetworkClient()
}
