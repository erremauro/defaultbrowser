//
//  HTTPHandlers.swift
//  defaultbrowser
//
//  Created by Roberto Mauro on 10/02/2020.
//  Copyright © 2020 Roberto Mauro. All rights reserved.
//

import Foundation

struct HTTPHandlers {
    static private let googleURL = URL(string: "http://www.google.com")!
    static private var handlerDictionary: [String:HTTPHandler]!
    static private var currentHandler: HTTPHandler!
    
    private struct protocols {
        static let http = "http" as CFString
        static let https = "https" as CFString
    }
    
    static var available: [String:HTTPHandler] {
        get {
            if (handlerDictionary != nil) { return handlerDictionary }
            
            let applicationURLs = LSCopyApplicationURLsForURL(googleURL as CFURL, .all)
            let appURLs = applicationURLs?.takeUnretainedValue() as! [URL]
            var dict: [String:HTTPHandler] = [:]
            
            for appURL in appURLs {
                let handler = HTTPHandler(url: appURL)
                let key = handler.name.lowercased()
                dict[key] = handler
            }
            
            handlerDictionary = dict
            return handlerDictionary
        }
    }
    
    static func isPresent(_ appName: String) -> Bool {
        return self.available.keys.contains(appName.lowercased())
    }
    
    static var current: HTTPHandler {
        get {
            if (currentHandler != nil) { return currentHandler }
            let applicationURL = LSCopyDefaultApplicationURLForURL(googleURL as CFURL, .all, nil)
            let appURL = applicationURL?.takeUnretainedValue() as URL?
            currentHandler = HTTPHandler(url: appURL!)
            
            return currentHandler
        }
        
        set {
            setDefaultHandler(withName: newValue.name)
        }
    }
    
    static func setDefaultHandler(withName appName: String) {
        let handler = available[appName.lowercased()]!.bundleId as CFString
        LSSetDefaultHandlerForURLScheme(protocols.http, handler)
        LSSetDefaultHandlerForURLScheme(protocols.https, handler)
    }
}
