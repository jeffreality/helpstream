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
    
    private let helpStream = HelpStream()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // This is an example of launching HelpStream via the user shaking the device
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            helpStream.launch()
        }
    }

    // This is an example of launching HelpStream from a button
    @IBAction func helpButtonTapped(_ sender: UIButton) {
        helpStream.launch()
    }
}

