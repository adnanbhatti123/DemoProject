//
//  Utilities.swift
//  DemoProject
//
//  Created by APPLE on 17/07/2020.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

typealias FailureBlock = (Error?) -> Void
typealias TSuccessBlockDictionary = ([String:Any]?) -> Void
typealias TSuccessBlockArray = ([[String:Any]]?) -> Void
typealias isSuccessfull = (Bool) -> Void
class Utilities: NSObject {
    // MARK: - Global Constants
    static let alert = "Alert"
    static let networkConnectionError = "Internet Connection not Available!"
    static let errorFetchingData = "Error occured while fetching data."
    static let unauthorizedAccess = "Unathorized"
    static let textFieldValidationMessage = "Please enter text"
    static let loginScreenTitle = "IS Test Project"
    static let welcomeMesasge = "Welcome"
    static let itemslistScreenTitle = "Details of listed Items:"
    
    // MARK: - Custom Methdos
    static func getBaseUrl() -> String{
        return "http://94.206.102.22/app/"
    }
    
    static func showAlert(_ titleValue:String?, message:String?)
    {
        let alert = UIAlertController(title: titleValue, message: NSLocalizedString(message ?? "", comment: "") , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.windows.first!.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
    }
}

enum apiName:String {
    case Login = "authenticate",
    Items = "item-list"
}
