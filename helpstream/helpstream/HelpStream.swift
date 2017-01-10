//
//  HelpStream.swift
//  HelpStream
//
//  Created by Jeffrey Berthiaume on 1/3/17.
//  Copyright © 2017 Pushplay. All rights reserved.
//

import Foundation

// init with enum for color, fonts, etc.

public class HelpStream: NSObject {
    
    public static let sharedInstance = HelpStream()
    
    public override init() {
    }
    
    public func launch(from viewController: UIViewController) {
        let bundle = Bundle(for: HelpStream.self)
        let storyboard = UIStoryboard(name: "HelpStream", bundle: bundle)
        let controller = storyboard.instantiateViewController(withIdentifier: "HelpStreamTabBarController")
        viewController.present(controller, animated: true, completion: nil)
    }
}
