//
//  StreamViewController.swift
//  HelpStream
//
//  Created by Jeffrey Berthiaume on 1/6/17.
//  Copyright © 2017 Pushplay. All rights reserved.
//

import Foundation

class StreamViewController: UIViewController {
    
    @IBOutlet weak var message: UITextView!
    
    var messagePlaceholder: UILabel = UILabel()
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        message.delegate = self
        
        // placeholder for message field
        messagePlaceholder.text = "Your message"
        messagePlaceholder.font = UIFont.systemFont(ofSize: 13)
        messagePlaceholder.sizeToFit()
        message.addSubview(messagePlaceholder)
        messagePlaceholder.frame.origin = CGPoint(x: 8, y: 8)
        messagePlaceholder.textColor = UIColor.lightGray
        messagePlaceholder.isHidden = !message.text.isEmpty
        
        // border formatting for message
        message.textContainerInset = UIEdgeInsetsMake(8, 4, 8, 4)
        message.layer.borderWidth = 1
        message.layer.borderColor = UIColor(hex: 0xe2e2e2).cgColor
    }
}

extension StreamViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        messagePlaceholder.isHidden = !textView.text.isEmpty
    }
    
}

extension StreamViewController: UITableViewDelegate {
    
}

extension StreamViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "FAQCategoryCell")
        cell.textLabel?.text = "row#\(indexPath.row)"
        
        return cell
    }
}

