//
//  FAQViewController.swift
//  HelpStream
//
//  Created by Jeffrey Berthiaume on 1/6/17.
//  Copyright © 2017 Pushplay. All rights reserved.
//

import Foundation

class FAQViewController: UIViewController {
    var faqData: [FAQCategory] = []
    var currentData: [FAQCategory] = []
    var faqIndex: [Int] = []
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBAction func closePanel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        navigationBar.topItem?.title = "Help"
        
        loadData()
        
        currentData = faqData
    }
    
    // FAQCategoryCell
    func loadData() {
        // add items to data
        let faq1 = FAQCategory(title: "1", details: "This is a test page", subCategories: nil)
        
        let faq2a = FAQCategory(title: "2a", details: "This is the second level", subCategories: nil)
        let faq2b = FAQCategory(title: "2b", details: "This is also the second level", subCategories: nil)
        
        let faq2 = FAQCategory(title: "2", details: nil, subCategories: [faq2a, faq2b])
        
        faqData = [faq1, faq2]
        
        print (faqData)
    }
}

extension FAQViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // if currentRow has string, pull up webview
        // else go to next level and refresh table
        let currentItem = currentData[indexPath.row]
        if let details = currentItem.details {
            // display webview
            print (details)
        } else if let subCategories = currentItem.subCategories {
            faqIndex.append(indexPath.row)
            navigationBar.topItem?.title = currentItem.title
            currentData = subCategories
            tableView.reloadData()
        }
    }
    
}

extension FAQViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "FAQCategoryCell")
        let currentItem: FAQCategory = currentData[indexPath.row]
        cell.textLabel?.text = currentItem.title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
