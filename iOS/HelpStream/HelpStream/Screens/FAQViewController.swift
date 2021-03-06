//
//  FAQViewController.swift
//  HelpStream
//
//  Created by Jeffrey Berthiaume on 1/6/17.
//  Copyright © 2017 Pushplay. All rights reserved.
//

import Foundation

class FAQViewController: UIViewController {
    var faqData: FAQCategories = []
    var currentData: FAQCategories = []
    
    var flatSearchData: FAQCategories = []
    var searchResultData: FAQCategories = []
    
    var faqIndex: [Int] = []
    var previousPageTitle: String = "Help"
    var webView: UIWebView = UIWebView()
    
    var shouldShowSearchResults: Bool = false
    var isLoading: Bool = false
    
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func closePanel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func goBack(_ sender: Any) {
        
        // if the webview is displayed, just hide it
        guard webView.isHidden == true else {
            webView.loadHTMLString("", baseURL: nil)
            webView.isHidden = true
            self.navigationItem.title = previousPageTitle
            return
        }
        
        // if we're in search mode, go back to the first screen
        if shouldShowSearchResults {
            shouldShowSearchResults = false
            setBackButton(isEnabled: false)
            self.navigationItem.title = "Help"
            searchBar.text = ""
            searchBar.resignFirstResponder()
            currentData = faqData
            tableView.reloadData()
            
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
        
        webView.loadHTMLString("", baseURL: nil)
        webView.isHidden = true
        self.view.addSubview(webView)
        
        spinner.frame = webView.frame
        self.view.addSubview(spinner)
        spinner.startAnimating()
        
        let hs = HelpStreamAPI.sharedInstance
        hs.delegate = self
        isLoading = true
        hs.getFAQ()
        
        setBackButton(isEnabled: false)
    }
    
    func flattenSearchData(categories: FAQCategories) -> FAQCategories {
        // go through all levels and flatten them
        var arr: FAQCategories = []
        for i in 0..<categories.count {
            let item = categories[i]
            if (item.answer != nil) {
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
        self.navigationItem.title = "Search Help..."
        searchResultData = []
        setBackButton(isEnabled: true)
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
        
        if (searchString?.characters.count)! > 2 {
            searchResultData = flatSearchData.filter({ (item) -> Bool in
                let str: NSString = item.title.appending(" ".appending(item.answer!)) as NSString
                return (str.range(of: searchString!, options: .caseInsensitive).location != NSNotFound)
            })
            
            shouldShowSearchResults = true
            
            if searchResultData.count == 0 {
                searchResultData = []
            }
            tableView.reloadData()
        }
    }
    
}

extension FAQViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // if currentRow has string, pull up webview
        // else go to next level and refresh table
        var currentItem: FAQCategory
        if shouldShowSearchResults {
            searchBar.resignFirstResponder()
            currentItem = searchResultData[indexPath.row]
        } else {
            currentItem = currentData[indexPath.row]
        }
        if let answer = currentItem.answer {
            tableView.deselectRow(at: indexPath, animated: true)
            setBackButton(isEnabled: true)
            webView.loadHTMLString(answer, baseURL: nil)
            webView.frame = tableView.frame
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
        if faqData.count > 0 {
            tableView.backgroundView = nil;
            return 1
        } else {
            if !isLoading {
                UITableViewEmpty.displayNoRowsMessage(viewController: self, tableView: tableView, message: "There are currently no answered questions.")
            }
            return 0
        }
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

extension FAQViewController: HelpStreamAPIDelegate {
    
    func jsonResponseReceived(json: [String : Any]) {
        guard let jsonNSArr = json["FAQ"] as? NSArray else {
            return
        }
        
        let jsonArr = jsonNSArr as Array
        
        var tempArr: [Int: FAQCategories] = [:]
        
        for item in jsonArr {
            let intFAQID = Int(item["intFAQID"] as! String)!
            let intParentID = Int(item["intParentID"] as! String)!
            let strTitle = item["strTitle"] as! String
            var strAnswer: String? = item["strAnswer"] as? String
            var subCategories: FAQCategories?
            
            if strAnswer == "" {
                strAnswer = nil
                
                subCategories = tempArr[intFAQID]
                tempArr[intFAQID] = nil
            }
            
            let FAQAnswer = FAQCategory(title: strTitle, answer: strAnswer, subCategories: subCategories)
            
            if let parentArr: FAQCategories = tempArr[intParentID] {
                tempArr[intParentID] = parentArr + [FAQAnswer]
            } else {
                tempArr[intParentID] = [FAQAnswer]
            }
        }
        
        faqData = []
        for dict in tempArr {
            faqData += dict.value
        }
        
        flatSearchData = flattenSearchData(categories: faqData)
        
        currentData = faqData
        
        
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
            self.spinner.stopAnimating()
            self.isLoading = false
        }
        
    }
    
    
}
