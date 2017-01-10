//
//  FAQViewController.swift
//  HelpStream
//
//  Created by Jeffrey Berthiaume on 1/6/17.
//  Copyright © 2017 Pushplay. All rights reserved.
//

import Foundation

class FAQViewController: UIViewController {
    
    @IBAction func closeButton() {
        self.dismiss(animated: true)
    }
    
    // FAQCategoryCell
}

extension FAQViewController: UITableViewDelegate {
    
}

extension FAQViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "FAQCategoryCell")
        cell.textLabel?.text = "row#\(indexPath.row)"
        
        return cell
    }
}
