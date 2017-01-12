//
//  UIColorExtensions.swift
//  HelpStream
//
//  Created by bloudermilk on 8/13/14.
//  http://stackoverflow.com/questions/24074257/how-to-use-uicolorfromrgb-value-in-swift
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
