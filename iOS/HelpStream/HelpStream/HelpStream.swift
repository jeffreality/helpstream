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
    
    // Calling app's custom UUID or other local identifier
    
    public var appUUID: String?
    
    // Debug information passed from calling application
    
    public var debugInfo: String?
    
    // URLs to webserver
    
    public var apiURL: URL?
    
    // things to initialize:
    // - colors, fonts of interface
    // - icon overrides?
    // - orientation support
    
    public override init() {
    }
    
    public func launch(from viewController: UIViewController) {
        HelpStreamAPI.sharedInstance.sendStats()
        
        let bundle = Bundle(for: HelpStream.self)
        let storyboard = UIStoryboard(name: "HelpStream", bundle: bundle)
        let controller = storyboard.instantiateViewController(withIdentifier: "HelpStreamTabBarController")
        viewController.present(controller, animated: true, completion: nil)
    }
    
    func getUUID() -> String {
        // check for custom uuid set by calling app
        if let appUUID = appUUID {
            return appUUID
        }
        
        let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let uuidKey = appName + ".uuid"
        
        // NOTE: because Keychain is implemented with third party git projects, I'm leaving the choice of that to the
        // app developer, and storing the HelpStream created uuid with UserDefaults
        
        // check for previously created uuid
        let defaults = UserDefaults.standard
        if let uuid = defaults.string(forKey: uuidKey) {
            appUUID = uuid
            return uuid
        }
        
        // create a uuid and store it in UserDefaults
        let uuid = UUID().uuidString
        defaults.setValue(uuid, forKey: uuidKey)
        
        appUUID = uuid
        return uuid
    }
}
