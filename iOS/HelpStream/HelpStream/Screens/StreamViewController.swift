//
//  StreamViewController.swift
//  HelpStream
//
//  Created by Jeffrey Berthiaume on 1/6/17.
//  Copyright © 2017 Pushplay. All rights reserved.
//

import Foundation

class StreamViewController: UIViewController {
    var streamData: Stream = []
    var pageIdx: Int = 0
    
    @IBOutlet weak var username: HSTextField!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var messagePlaceholder: UILabel = UILabel()
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        self.navigationItem.title = "Chat Stream"
        
        username.delegate = self
        message.delegate = self
        
        let hs = HelpStreamAPI.sharedInstance
        hs.delegate = self
        hs.getStream(page: pageIdx)
        
        // placeholder for message field
        messagePlaceholder.text = "Your message"
        messagePlaceholder.font = UIFont.systemFont(ofSize: 13)
        messagePlaceholder.sizeToFit()
        message.addSubview(messagePlaceholder)
        messagePlaceholder.frame.origin = CGPoint(x: 8, y: 8)
        messagePlaceholder.textColor = UIColor.lightGray
        messagePlaceholder.isHidden = !message.text.isEmpty
        
        // border formatting for email
        username.layer.borderWidth = 1
        username.layer.borderColor = UIColor(hex: 0xe2e2e2).cgColor
        
        // border formatting for message
        message.textContainerInset = UIEdgeInsetsMake(8, 4, 8, 4)
        message.layer.borderWidth = 1
        message.layer.borderColor = UIColor(hex: 0xe2e2e2).cgColor
        
        loadCachedUsername()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startObservingKeyboardEvents()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopObservingKeyboardEvents()
    }
    
    func startObservingKeyboardEvents() {
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(keyboardWillShow(_:)),
                                               name:NSNotification.Name.UIKeyboardWillShow,
                                               object:nil)
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(keyboardWillHide(_:)),
                                               name:NSNotification.Name.UIKeyboardWillHide,
                                               object:nil)
    }
    
    func stopObservingKeyboardEvents() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.bottomConstraint.constant = keyboardFrame.size.height - 40
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.bottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    func loadCachedUsername() {
        let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let emailKey = appName + ".user_name"
        
        if let email = UserDefaults.standard.string(forKey: emailKey) {
            username.text = email
        }
    }
    
    func cacheUsername() {
        let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let emailKey = appName + ".user_name"
        
        UserDefaults.standard.setValue(username.text, forKey: emailKey)
    }
    
    func updateUsername() {
        let hsapi = HelpStreamAPI()
        hsapi.delegate = self
        hsapi.setStreamProfile(username: username.text!)
    }
    
    func submitChatMessage() {
        let hsapi = HelpStreamAPI()
        hsapi.delegate = self
        hsapi.addStreamMessage(message: message.text!)
    }
}

extension StreamViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cacheUsername()
        updateUsername()
        textField.resignFirstResponder()
        message.becomeFirstResponder()
        return false
    }
}

extension StreamViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        messagePlaceholder.isHidden = !textView.text.isEmpty
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newLine = "\n"
        if text == newLine {
            
            submitChatMessage()
            message.text = ""
            
            message.resignFirstResponder()
            
            // JBB TODO
            // refresh chat
            
            return false
        } else {
            return true
        }
    }
    
}

extension StreamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Mute"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
}

extension StreamViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if streamData.count > 0 {
            return 1
        } else {
            UITableViewEmpty.displayNoRowsMessage(viewController: self, tableView: tableView, message: "There are no chat messages yet. Go ahead and start the conversation yourself!")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streamData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "StreamMessageCell")
        // or UserMessageCell
        cell.textLabel?.text = "row#\(indexPath.row)"
        
        return cell
    }
}

extension StreamViewController: HelpStreamAPIDelegate {
    
    func getStreams(myDeviceID: String, streams: NSArray) {
        let jsonArr = streams as Array
        
        print (jsonArr)
        
        for item in jsonArr {
//            let date = item["dateCreated"] as! String
//            let username = item["strUsername"] as! String
//            let color = item["strColor"] as! String
//            let message = item["strMessage"] as! String
            
            
        }

    }
    
    func setStream(response: String) {
        
    }
    
    func setStreamProfile(response: String) {
        
    }
    
    func jsonResponseReceived(json: [String : Any]) {
        
        DispatchQueue.main.async { [unowned self] in
            
            print (json)
            
            if let jsonNSArr = json["stream"] as? NSArray {
                let deviceID = json["intDeviceID"] as! String
                self.getStreams(myDeviceID: deviceID, streams: jsonNSArr)
            } else if let jsonResult = json["stream_response"] as? String {
                self.setStream(response: jsonResult)
            } else if let jsonResult = json["profile_response"] as? String {
                self.setStreamProfile(response: jsonResult)
            }
            
            self.tableView.reloadData()
        }
        
        
    }
    
    
}
