//
//  ContactViewController.swift
//  HelpStream
//
//  Created by Jeffrey Berthiaume on 1/6/17.
//  Copyright © 2017 Pushplay. All rights reserved.
//

import Foundation
import QuartzCore

class ContactViewController: UIViewController {
    
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var debugView: UIView!
    @IBOutlet weak var debugToggle: UIButton!
    
    var messagePlaceholder: UILabel = UILabel()
    
    @IBAction func closeButton() {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        message.delegate = self
        
        debugToggle.isSelected = true
        
        // placeholder for message field
        messagePlaceholder.text = "Message (optional)"
        messagePlaceholder.font = UIFont.systemFont(ofSize: 13)
        messagePlaceholder.sizeToFit()
        message.addSubview(messagePlaceholder)
        messagePlaceholder.frame.origin = CGPoint(x: 8, y: 8)
        messagePlaceholder.textColor = UIColor.lightGray
        messagePlaceholder.isHidden = !message.text.isEmpty
        
        // border formatting for email
        emailAddress.layer.borderWidth = 1
        emailAddress.layer.borderColor = UIColor(hex: 0xe2e2e2).cgColor
        
        // border formatting for message
        message.textContainerInset = UIEdgeInsetsMake(8, 4, 8, 4)
        message.layer.borderWidth = 1
        message.layer.borderColor = UIColor(hex: 0xe2e2e2).cgColor
        
        // border formatting for debugView
        debugView.layer.borderWidth = 1
        debugView.layer.borderColor = UIColor(hex: 0xe2e2e2).cgColor
    }
    
    @IBAction func debugToggled(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.alpha = sender.isSelected ? 1 : 0.2
    }
}

extension ContactViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        messagePlaceholder.isHidden = !textView.text.isEmpty
    }
    
}
