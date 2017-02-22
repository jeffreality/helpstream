//
//  StreamMessage.swift
//  HelpStream
//
//  Created by Jeffrey Berthiaume on 1/25/17.
//  Copyright © 2017 Pushplay. All rights reserved.
//

import Foundation

struct StreamMessage {
    var avatar: NSURL?
    var name: String?
    var message: String
}

typealias Stream = [StreamMessage]
