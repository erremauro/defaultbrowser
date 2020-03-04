//
//  JSONScriptFilter.swift
//  defaultbrowser
//
//  Created by Roberto Mauro on 10/02/2020.
//  Copyright © 2020 Roberto Mauro. All rights reserved.
//

import Foundation

enum JSONScriptFilterError : Error {
    case serialize(String)
}

struct JSONScriptFilterItemIcon : Codable {
    var path: String
}

struct JSONScriptFilterItem : Codable {
    var uuid: String
    var title: String
    var subtitle: String
    var arg: String
    var icon: JSONScriptFilterItemIcon
    var valid: Bool
    
    init(title: String, subtitle: String, arg: String, icon: String, valid: Bool = true) {
        self.uuid = UUID().uuidString
        self.title = title
        self.subtitle = subtitle
        self.arg = arg
        self.icon = JSONScriptFilterItemIcon(path: icon)
        self.valid = valid
    }
}

struct JSONScriptFilter : Codable {
    var items: [JSONScriptFilterItem] = []
}
