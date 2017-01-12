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
    
    var flatSearchData: [FAQCategory] = []
    var searchResultData: [FAQCategory] = []
    
    var faqIndex: [Int] = []
    var previousPageTitle: String = "Help"
    var webView: UIWebView = UIWebView()
    
    var shouldShowSearchResults: Bool = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func closePanel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func goBack(_ sender: Any) {
        
        // if the webview is displayed, just hide it
        guard webView.isHidden == true else {
            webView.isHidden = true
            self.navigationItem.title = previousPageTitle
            return
        }
        
        // delete the last item from faqIndex
        // navigate through faqData
        // reset the backButton
        // reload the tableView
        
        faqIndex.removeLast()
        currentData = faqData
        var currentItem: FAQCategory? = nil
        for i in 0..<faqIndex.count {
            let idx = faqIndex[i]
            currentItem = currentData[idx]
            currentData = (currentItem?.subCategories!)!
        }
        if (currentItem != nil)  {
            self.navigationItem.title = currentItem?.title
        } else {
            self.navigationItem.title = "Help"
        }
        setBackButton(isEnabled: (faqIndex.count > 0))
        tableView.reloadData()
        
    }
    
    func setBackButton(isEnabled: Bool) {
        backButton.isEnabled = isEnabled
        backButton.tintColor = isEnabled ? self.navigationItem.titleView?.tintColor : UIColor.clear
    }
    
    override func viewDidLoad() {
        self.navigationItem.title = "Help"
        
        self.view.addSubview(webView)
        webView.frame = tableView.frame
        webView.isHidden = true
        
        loadData()
        flatSearchData = flattenSearchData(categories: faqData)
        
        currentData = faqData
        
        setBackButton(isEnabled: false)
    }
    
    func loadData() {
        // add items to data
        let faq1 = FAQCategory(title: "1", details: "This is a test page", subCategories: nil)
        
        let faq2a = FAQCategory(title: "2a", details: "This is the second level", subCategories: nil)
        let faq2b = FAQCategory(title: "2b", details: "This is also the second level", subCategories: nil)
        
        let faq2 = FAQCategory(title: "2", details: nil, subCategories: [faq2a, faq2b])
        
        faqData = [faq1, faq2]
        
        //print (faqData)
    }
    
    func flattenSearchData(categories: [FAQCategory]) -> [FAQCategory] {
        // go through all levels and flatten them
        var arr: [FAQCategory] = []
        for i in 0..<categories.count {
            let item = categories[i]
            if (item.details != nil) {
                arr.append(item)
            } else if let subCategories = item.subCategories {
                arr = arr + flattenSearchData(categories: subCategories)
            }
        }
        return arr
    }
}

extension FAQViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchString = searchBar.text
        
        searchResultData = flatSearchData.filter({ (item) -> Bool in
            let str: NSString = item.title.appending(" ".appending(item.details!)) as NSString
            return (str.range(of: searchString!, options: .caseInsensitive).location != NSNotFound)
        })
        
        if searchResultData.count == 0 {
            shouldShowSearchResults = false
        } else {
            shouldShowSearchResults = true
        }
        tableView.reloadData()
    }
    
}

extension FAQViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // if currentRow has string, pull up webview
        // else go to next level and refresh table
        let currentItem = currentData[indexPath.row]
        if let details = currentItem.details {
            setBackButton(isEnabled: true)
            webView.loadHTMLString(details, baseURL: nil)
            webView.isHidden = false
            previousPageTitle = self.navigationItem.title!
            self.navigationItem.title = currentItem.title
        } else if let subCategories = currentItem.subCategories {
            faqIndex.append(indexPath.row)
            setBackButton(isEnabled: true)
            self.navigationItem.title = currentItem.title
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
        if shouldShowSearchResults == true {
            return searchResultData.count
        } else {
            return currentData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "FAQCategoryCell")
        
        var currentItem: FAQCategory
        if shouldShowSearchResults == true {
            currentItem = searchResultData[indexPath.row]
        } else {
            currentItem = currentData[indexPath.row]
        }
        
        cell.textLabel?.text = currentItem.title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
