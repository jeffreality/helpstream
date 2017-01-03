//
//  Storyboardable.swift
//  HelpStream
//
//  Created by Jeffrey Berthiaume on 1/3/17.
//  Copyright © 2017 Pushplay. All rights reserved.
//

import Foundation

private let posixLocale = Locale(identifier: "en_US_POSIX")

public protocol Storyboardable: class {
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle? { get }
}

public extension Storyboardable where Self: UIViewController {
    
    static var storyboardName: String {
        var className = String(describing: self)
        guard let range = className.range(of: "ViewController", options: [.backwards, .anchored], range: nil, locale: posixLocale) else {
            return className
        }
        
        className.removeSubrange(range)
        return className
    }
    
    static var storyboardBundle: Bundle? {
        return Bundle(for: self)
    }
    
}

public extension Storyboardable where Self: UIViewController {
    
    static func _instantiateFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        guard let viewController = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Could not instantiate initial view controller. Is the Type set correctly?")
        }
        
        return viewController
    }
    
}
