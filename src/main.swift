//
//  main.swift
//  defaultbrowser
//
//  Created by Roberto Mauro on 09/02/2020.
//  Copyright © 2020 Roberto Mauro. All rights reserved.
//

import Foundation
import ApplicationServices

func Main(cmdParseResult: CommandLineParseResult) throws {
    
    let target = cmdParseResult.parsedArguments.joined(separator: " ")
    
    try autoreleasepool {
        if (target == "") {
            // Return command line output
            let isAlfredOutput = cmdParseResult.isPresent(optionNamed: "alfred")
            
            if (!isAlfredOutput) {
                let isVerbose = cmdParseResult.isPresent(optionNamed: "verbose")
                let isCompact = cmdParseResult.isPresent(optionNamed: "compact")
                                
                for key in HTTPHandlers.available.keys.sorted() {
                    let browser = HTTPHandlers.available[key]!
                    var message = browser.name
                    
                    if (HTTPHandlers.current == browser) {
                        message = isCompact ? "\(message)*" : "* \(message)"
                    } else {
                        message = isCompact ? message : "  \(message)"
                    }
                    
                    if (isVerbose) {
                        message += isCompact ? "\n  \(browser.url)" : "\n    \(browser.url)"
                    }
                    
                    print(message)
                }
                return
            }
            // Returns Alfred's JSON Script Filter output
            var scriptFilter = JSONScriptFilter()
            for key in HTTPHandlers.available.keys.sorted() {
                let browser = HTTPHandlers.available[key]!
                scriptFilter.items.append(
                    JSONScriptFilterItem(
                        title: browser.title,
                        subtitle: "Action this item to set this browser as the default",
                        arg: browser.name,
                        icon: browser.icon
                    )
                )
            }
            
            do {
                let jsonData = try JSONEncoder().encode(scriptFilter)
                let jsonString = String(data: jsonData, encoding: .utf8)!
                
                print(jsonString)
            }
            catch {
                throw JSONScriptFilterError.serialize("Unable to serialize JSON Script Filter object")
            }
        } else {
            if !HTTPHandlers.isPresent(target) {
                print("Handler \"\(target)\" not found.")
                exit(0)
            }
            
            HTTPHandlers.setDefaultHandler(withName: target)
        }
    }
}

do {
    let optionDefitions = [
        CommandLineOptionDefinition(
            name: "help",
            letter: "h",
            valueType: .noValue,
            briefHelp: "Show this help message"
        ),
        CommandLineOptionDefinition(
            name: "verbose",
            letter: "v",
            valueType: .noValue,
            briefHelp: "Print handlers details"
        ),
        CommandLineOptionDefinition(
            name: "compact",
            letter: "c",
            valueType: .noValue,
            briefHelp: "Print compact output"
        ),
        CommandLineOptionDefinition(
            name: "alfred",
            letter: "a",
            valueType: .noValue,
            briefHelp: "Print Alfred's JSON Script Filter output"
        )
    ]
    
    let result = try CommandLineParseResult(arguments: CommandLine.arguments, optionDefinitions: optionDefitions)
    
    if (result.isPresent(optionNamed: "help")) {
        print("Change the default browser.")
        print()
        print("Usage:")
        print("  defaultbrowser [-cv]")
        print("  defaultbrowser <BROWSER>")
        print("  defaultbrowser --alfred")
        print()
        print("Options:")
        printHelp(optionDefinitions: optionDefitions)
        exit(0)
    }
    
    try Main(cmdParseResult: result)
}
catch let error {
    print("Error: \(error)")
}
