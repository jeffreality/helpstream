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
    var messageResponse: UILabel = UILabel()
    
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        emailAddress.delegate = self
        message.delegate = self
        
        debugToggle.isSelected = true
        
        spinner.frame = message.frame
        self.view.addSubview(spinner)
        spinner.stopAnimating()
        
        messageResponse.frame = message.frame
        messageResponse.numberOfLines = 0
        self.view.addSubview(messageResponse)
        messageResponse.isHidden = true
        
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
        
        loadCachedEmailAddress()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        emailAddress.isHidden = false
        message.isHidden = false
        debugView.isHidden = false
        
        messageResponse.isHidden = true
    }
    
    @IBAction func debugToggled(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.alpha = sender.isSelected ? 1 : 0.2
    }
    
    func isValidEmail(test: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: test)
    }
    
    func sendMessage() {
        let hsapi = HelpStreamAPI()
        hsapi.delegate = self
        hsapi.sendContactForm(email: emailAddress.text!, message: message.text!, debug: debugToggle.isSelected)
    }
    
    func loadCachedEmailAddress() {
        let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let emailKey = appName + ".user_email"
        
        if let email = UserDefaults.standard.string(forKey: emailKey) {
            emailAddress.text = email
        }
    }
    
    func cacheEmailAddress() {
        let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let emailKey = appName + ".user_email"
        
        UserDefaults.standard.setValue(emailAddress.text, forKey: emailKey)
    }
}

extension ContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        message.becomeFirstResponder()
        return true
    }
}

extension ContactViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        messagePlaceholder.isHidden = !textView.text.isEmpty
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newLine = "\n"
        if text == newLine {
            // check for valid email
            guard isValidEmail(test: emailAddress.text!) else {
                emailAddress.backgroundColor = UIColor.red
                emailAddress.textColor = UIColor.white
                emailAddress.becomeFirstResponder()
                return false
            }
            
            sendMessage()
            cacheEmailAddress()
            
            message.text = ""
            
            emailAddress.isHidden = true
            message.isHidden = true
            debugView.isHidden = true
            
            spinner.startAnimating()
            
            textView.resignFirstResponder()
            return false
        } else {
            return true
        }
    }
    
}

extension ContactViewController: HelpStreamAPIDelegate {
    func jsonResponseReceived(json: [String: Any]) {
        // do something
        print (json)
        
        DispatchQueue.main.async { [unowned self] in
            // on successful completion
            self.spinner.stopAnimating()
            self.messageResponse.text = "Thank you! Your message has been sent to the developers of this app!"
            self.messageResponse.isHidden = false
        }
    }
}
