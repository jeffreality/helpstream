//
//  HelpStreamAPI.swift
//  HelpStream
//
//  Created by Jeffrey Berthiaume on 1/14/17.
//  Copyright © 2017 Pushplay. All rights reserved.
//

import Foundation
import SystemConfiguration

class HelpStreamAPI {
    
    static let sharedInstance = HelpStreamAPI()
    
    var urlRequest: NSMutableURLRequest = NSMutableURLRequest()
    var isNetworkAvailable: Bool = false
    var checkingNetwork: Bool = false
    
    /*
    
    helpStream.urlSetStream = URL(string: "http://b635.com/helpstream/set-stream.php")
     - get user
     - if user not created, create one with number (total users * 10, if < 10000 add 10000, then pick random number -> confirm it is unique)
     - write to tblStreams
     
    helpStream.urlSetStreamProfile = URL(string: "http://b635.com/helpstream/set-stream-profile.php")
     - just change name of tblUsers where intDeviceID = same
    
    */
    
    weak var delegate: HelpStreamAPIDelegate?
    
    func checkNetworkAvailability(url: URL) -> Bool {
        if (!checkingNetwork) {
            checkingNetwork = true
            
            guard
                let scheme = url.scheme,
                let host = url.host else {
                return false
            }
            
            let domain = scheme + "://" + host
            
            if let reachability = SCNetworkReachabilityCreateWithName(nil, domain) {
                var flags: SCNetworkReachabilityFlags = []
                let success = SCNetworkReachabilityGetFlags(reachability, &flags)
                
                let isReachable = flags.contains(.reachable)
                let connectionRequired = flags.contains(.connectionRequired)
                
                isNetworkAvailable = success && isReachable && !connectionRequired
            }
        }
        checkingNetwork = false
        return isNetworkAvailable
    }
    
    func sendStats() {
        guard let url = getApiUrl(path: "/stats.php") else {
            assert (false, "HSError: send stats url (urlSendStats) not configured in HelpStream")
            return
        }
        
        guard checkNetworkAvailability(url: url) else {
            assert (false, "HSError: network not reachable")
            return
        }
        
        let uuid = HelpStream.sharedInstance.getUUID()
        
        let device = UIDevice.current
        let currentLanguage = NSLocale.preferredLanguages[0] as String
        
        let requestString = String(format: "a=%@&b=%@&c=%@&d=%@&e=%@&f=%@&g=%@&h=%@",
                                   device.name,
                                   device.model,
                                   device.localizedModel,
                                   device.systemName,
                                   device.systemVersion,
                                   uuid,
                                   NSLocale.current.identifier,
                                   currentLanguage).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as String
        
        requestJson(url: url, method: "POST", body: requestString)
    }
    
    func sendContactForm(email: String, message: String, debug: Bool) {
        let hs = HelpStream.sharedInstance
        
        guard let url = getApiUrl(path: "/submit-contact-form.php") else {
            assert (false, "HSError: submit contact form url not configured in HelpStream")
            return
        }
        
        guard checkNetworkAvailability(url: url) else {
            assert (false, "HSError: network not reachable")
            return
        }
        
        let uuid = hs.getUUID()
        
        var debugDetails = ""
        if debug,
            let debugInfo = hs.debugInfo {
            debugDetails = debugInfo
        }
        
        let requestString = String(format: "id=%@&email=%@&message=%@&debug=%@",
                                   uuid,
                                   email,
                                   message,
                                   debugDetails).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as String
        
        requestJson(url: url, method: "POST", body: requestString)
    }
    
    func getFAQ() {
        let hs = HelpStream.sharedInstance
        
        guard let url = getApiUrl(path: "/get-faq.php") else {
            assert (false, "HSError: get FAQ url not configured in HelpStream")
            return
        }
        
        guard checkNetworkAvailability(url: url) else {
            assert (false, "HSError: network not reachable")
            return
        }
        
        let uuid = hs.getUUID()
        
        let requestString = String(format: "id=%@", uuid)
        
        requestJson(url: url, method: "POST", body: requestString)
    }
    
    func getStream(page: Int) {
        let hs = HelpStream.sharedInstance
        
        guard let url = getApiUrl(path: "/get-streams.php") else {
            assert (false, "HSError: get stream url not configured in HelpStream")
            return
        }
        
        guard checkNetworkAvailability(url: url) else {
            assert (false, "HSError: network not reachable")
            return
        }
        
        let uuid = hs.getUUID()
        
        let requestString = String(format: "id=%@&pg=%i", uuid, page)
        
        requestJson(url: url, method: "POST", body: requestString)
    }
    
    func addStreamMessage(message: String) {
        let hs = HelpStream.sharedInstance
        
        guard let url = getApiUrl(path: "/set-stream.php") else {
            assert (false, "HSError: set stream message url not configured in HelpStream")
            return
        }
        
        guard checkNetworkAvailability(url: url) else {
            assert (false, "HSError: network not reachable")
            return
        }
        
        let uuid = hs.getUUID()
        
        let requestString = String(format: "id=%@&msg=%@",
                                   uuid,
                                   message).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as String
        
        requestJson(url: url, method: "POST", body: requestString)
    }
    
    func setStreamProfile(username: String) {
        let hs = HelpStream.sharedInstance
        
        guard let url = getApiUrl(path: "/set-stream-profile.php") else {
            assert (false, "HSError: set stream profile url not configured in HelpStream")
            return
        }
        
        guard checkNetworkAvailability(url: url) else {
            assert (false, "HSError: network not reachable")
            return
        }
        
        let uuid = hs.getUUID()
        
        let requestString = String(format: "id=%@&name=%@",
                                   uuid,
                                   username).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as String
        
        requestJson(url: url, method: "POST", body: requestString)
    }
    
    // =========================
    // =========================
    // =========================
    // =========================
    
    func getApiUrl(path: String) -> URL? {
        guard let apiURL = HelpStream.sharedInstance.apiURL else {
            assert (false, "HSError: API url not configured properly in HelpStream")
            return nil
        }
        
        return (URL(string: apiURL.absoluteString + path))
    }
    
    func requestJson(url: URL, method: String, body: String) {
        
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        request.httpBody = body.data(using: .utf8)
        
        let _ = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            do{
                let resultJSON = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                let dictJSON = resultJSON as! [String: Any]
                self.delegate?.jsonResponseReceived(json: dictJSON)
                
//                for value in arrayJSON {
//                    let dicValue = value as! NSDictionary
//                    for (key, value) in dicValue {
//                        print("key = \(key)")
//                        print("value = \(value)")
//                    }
//                }
                
            } catch _ {
                print("Received not-well-formatted JSON")
            }
            
        }).resume()
        
    }
    
}

protocol HelpStreamAPIDelegate: class {
    func jsonResponseReceived(json: [String: Any]) // by design, all responses will be Dictionaries and not Arrays
}
