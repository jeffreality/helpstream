//
//  ViewController.swift
//  helpstream_demo
//
//  Created by Jeffrey Berthiaume on 1/3/17.
//  Copyright © 2017 Pushplay. All rights reserved.
//

import UIKit
import HelpStream

class ViewController: UIViewController {
    
    private let helpStream = HelpStream.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure helpStream options from your app:
        
        // helpStream.appUUID = UUID().uuidString
        
        // If you have your own local uuid for your app, you can set it above (or uncomment the line above to test).
        // This is optional and you do not need to set it.
        
        // You MUST set this urls for information to be stored on/loaded from your webserver:
        helpStream.apiURL = URL(string: "http://b635.com/helpstream")
    
    }
    
    // This is an example of launching HelpStream via the user shaking the device
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            helpStream.launch(from: self)
        }
    }

    // This is an example of launching HelpStream from a button
    @IBAction func helpButtonTapped(_ sender: UIButton) {
        helpStream.launch(from: self)
    }
}

