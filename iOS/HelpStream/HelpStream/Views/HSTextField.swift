//
//  HSTextField.swift
//  HelpStream
//
//  Created by Jeffrey Berthiaume on 1/9/17.
//  Copyright © 2017 Pushplay. All rights reserved.
//

import Foundation

class HSTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 4)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    
}
