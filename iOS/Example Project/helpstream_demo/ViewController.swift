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
        
        // You MUST set all of the following urls for this to work:
        helpStream.urlSendStats = URL(string: "http://b635.com/helpstream/stats.php")
        
        helpStream.urlGetStream = URL(string: "http://b635.com/helpstream/get-stream.php")
        helpStream.urlSetStream = URL(string: "http://b635.com/helpstream/set-stream.php")
        helpStream.urlSetStreamProfile = URL(string: "http://b635.com/helpstream/set-stream-profile.php")
        helpStream.urlUploadStreamAvatar = URL(string: "http://b635.com/helpstream/upload-stream-avatar.php")
        
        helpStream.urlCheckFAQVersion = URL(string: "http://b635.com/helpstream/check-faq-version.php")
        helpStream.urlGetFAQ = URL(string: "http://b635.com/helpstream/get-faq.php")
        
        helpStream.urlSubmitContactForm = URL(string: "http://b635.com/helpstream/submit-contact-form.php")
    
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

