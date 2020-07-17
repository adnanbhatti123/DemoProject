//
//  ViewModel.swift
//  DemoProject
//
//  Created by APPLE on 17/07/2020.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    static var shared = ViewModel()
    fileprivate var items = [Item]()
    fileprivate var authObj:AuthInfo?
    
    
    func getItemsList() -> [Item]{
        return self.items
    }
    
    func getAuthInfo() -> AuthInfo{
        return self.authObj!
    }
    
    //MARK: - Custotomize Model Object Properties
    func getName(item:Item) -> String{
        return "\(item.name ?? "")"
    }
    
    func getDescription(item:Item) -> String{
        return "\(item.itemDescription ?? "")"
    }
    
    func getPrice(item:Item) -> String{
        return  String(format: "Price: %.1f", item.price ?? 0)
    }
    
    //MARK: - Perform Api Calls
    func performLogin(userName:String, password:String, onSuccess:@escaping isSuccessfull , onFailure: @escaping FailureBlock){
        let urlString = Utilities.getBaseUrl() + apiName.Login.rawValue
        let params: [String : Any] = [
            "username": userName,
            "password":password]
        NetworkCalls.shared.sendPostRequest(urlString: urlString, params: params, token: "", onSuccess: {[unowned self] (success) in
            if let accessToken = success!["token"] as? String{
                self.authObj = AuthInfo(username: userName, password: password, accessToken: accessToken)
                onSuccess(true)
                return
            }
            onSuccess(false)
            
        }) { (error) in
            onFailure(error)
        }
    }
    
    func fetchItemList(onSuccess:@escaping isSuccessfull , onFailure: @escaping FailureBlock){
        let urlString = Utilities.getBaseUrl() + apiName.Items.rawValue
        NetworkCalls.shared.sendPostRequest(urlString: urlString, params: [:], token: self.getAuthInfo().accessToken, onSuccess: {[unowned self] (response) in
            if let itemsList = response!["itemList"] as? [[String:Any]]{
                for item in itemsList{
                    let itemObj = Item.init(item: item)
                    self.items.append(itemObj)
                }
                onSuccess(true)
                return
            }
            onSuccess(false)
        }) { (error) in
            onFailure(error)
        }
    }
    
    
}
