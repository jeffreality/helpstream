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
        guard let url = HelpStream.sharedInstance.urlSendStats else {
            assert (false, "HSError: send stats url (urlSendStats) not configured in HelpShift")
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
    
    func sendContactForm(url: URL, email: String, message: String, debug: Bool) {
        let hs = HelpStream.sharedInstance
        
        guard let url = HelpStream.sharedInstance.urlSubmitContactForm else {
            assert (false, "HSError: submit contact url (urlSubmitContactForm ) not configured in HelpShift")
            return
        }
        
        guard checkNetworkAvailability(url: url) else {
            assert (false, "HSError: network not reachable")
            return
        }
        
        let uuid = HelpStream.sharedInstance.getUUID()
        
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
    
    // =========================
    
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
