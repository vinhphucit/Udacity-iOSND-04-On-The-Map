//
//  LocationModel.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/4/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation

struct StudentInformation: Codable {
    
    let createdAt: String?
    let firstName: String?
    let lastName: String?
    let latitude: Double?
    let longitude: Double?
    let mapString: String?
    let mediaURL: String?
    let objectId: String?
    let uniqueKey: String?
    let updatedAt: String?
    
    init(_ dictionary: [String: AnyObject]) {
        self.objectId = dictionary["objectId"] as? String
        self.uniqueKey = dictionary["uniqueKey"] as? String ?? ""
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.mapString = dictionary["mapString"] as? String ?? ""
        self.mediaURL = dictionary["mediaURL"] as? String ?? ""
        self.latitude = dictionary["latitude"] as? Double ?? 0.0
        self.longitude = dictionary["longitude"] as? Double ?? 0.0
        self.createdAt = dictionary["createdAt"] as? String ?? nil
        self.updatedAt = dictionary["updatedAt"] as? String ?? nil
    }
}
