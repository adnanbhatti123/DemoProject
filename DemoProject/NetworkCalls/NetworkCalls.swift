//
//  NetworkCalls.swift
//  DemoProject
//
//  Created by APPLE on 17/07/2020.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit


class NetworkCalls: NSObject {
    static let shared = NetworkCalls()
    
    func sendPostRequest(urlString: String, params: [String: Any], token:String, onSuccess: @escaping TSuccessBlockDictionary , onFailure: @escaping FailureBlock) {
        let task = getUrlSessionObject().dataTask(with: getRequestObject(urlString: urlString, params: params, token: token), completionHandler: {(data, response, error) in
            if(error == nil) {
                do {
                    let dicObj = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    onSuccess((dicObj as! [String:Any]))
                }
                catch let e {
                    print(e.localizedDescription)
                    onFailure(e as Error)
                }
            }
            else {
                onFailure(error! as Error)
            }
        });
        
        task.resume()
    }
    
    fileprivate func getRequestObject(urlString:String, params:[String:Any], token:String) -> URLRequest{
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 60.0
        request.addValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json;charset=UTF-8", forHTTPHeaderField: "Accept")
        if(!token.isEmpty){
           request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        return request
    }
    
    fileprivate func getUrlSessionObject() -> URLSession{
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }
}
