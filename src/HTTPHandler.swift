//
//  HttpHandler.swift
//  defaultbrowser
//
//  Created by Roberto Mauro on 10/02/2020.
//  Copyright © 2020 Roberto Mauro. All rights reserved.
//

import Foundation

struct HTTPHandler {
    var bundleId: String
    var name: String
    var title: String
    var icon: String
    var url: URL
    
    init(url: URL) {
        let bundle = Bundle.init(url: url)!
        
        self.url = url
        self.title = bundle.infoDictionary?["CFBundleName"] as! String
        self.name = self.title.lowerCamelCased
        self.bundleId = bundle.bundleIdentifier!
        
        let iconFile = bundle.infoDictionary?["CFBundleIconFile"] as! String
        var iconName = iconFile
        
        if (iconFile.contains(".")) {
            iconName = String(iconFile.split(separator: ".").first!)
        }
        
        self.icon = bundle.path(forResource: iconName as String, ofType: "icns")!
    }
    
    static func == (lhs: HTTPHandler, rhs: HTTPHandler) -> Bool {
        return lhs.bundleId == rhs.bundleId
    }
}
