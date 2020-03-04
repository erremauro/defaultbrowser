//
//  StringExtension.swift
//  defaultbrowser
//
//  Created by Roberto Mauro on 10/02/2020.
//  Copyright © 2020 Roberto Mauro. All rights reserved.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }

    var upperCamelCased: String {
        return self.lowercased()
            .split(separator: " ")
            .map { return $0.lowercased().capitalizingFirstLetter() }
            .joined()
    }
    
    var lowerCamelCased: String {
        let upperCased = self.upperCamelCased
        return upperCased.prefix(1).lowercased() + upperCased.dropFirst()
    }
}
