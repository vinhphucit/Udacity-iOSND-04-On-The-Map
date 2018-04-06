//
//  MiscUtils.swift
//  OnTheMap
//
//  Created by Phuc Tran on 4/2/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import Foundation
import UIKit
class MiscUtils {
    static func openExternalLink(_ url: String?) {
        if let url = url, let urllink = URL(string: url) {
            UIApplication.shared.open(urllink, options: [:])
        }
    }
}
