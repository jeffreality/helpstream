//
//  FAQCategory.swift
//  HelpStream
//
//  Created by Jeffrey Berthiaume on 1/10/17.
//  Copyright © 2017 Pushplay. All rights reserved.
//

import Foundation

struct FAQCategory {
    var title: String
    var details: String?
    var subCategories: [FAQCategory]?
}
