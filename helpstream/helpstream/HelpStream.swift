//
//  HelpStream.swift
//  HelpStream
//
//  Created by Jeffrey Berthiaume on 1/3/17.
//  Copyright © 2017 Pushplay. All rights reserved.
//

import Foundation

// init with enum for color, fonts, etc.

public class HelpStream {
    
    public static let sharedInstance = HelpStream()
    
    public init() {
    }
    
    public func launch() {
        print("Yeah, it works")
    }
}
