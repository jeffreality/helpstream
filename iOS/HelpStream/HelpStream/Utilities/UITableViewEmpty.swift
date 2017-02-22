//
//  UITableViewEmpty.swift
//  HelpStream
//
//  Created by Jeffrey Berthiaume on 1/26/17.
//  Copyright © 2017 Pushplay. All rights reserved.
//

import Foundation

class UITableViewEmpty {
    
    class func displayNoRowsMessage(viewController:UIViewController, tableView: UITableView, message:String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: viewController.view.bounds.size.width, height: viewController.view.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.sizeToFit()
        
        tableView.backgroundView = messageLabel;
        tableView.separatorStyle = .none;
    }
    
}
