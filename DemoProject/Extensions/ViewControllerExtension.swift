//
//  ViewControllerExtension.swift
//  DemoProject
//
//  Created by APPLE on 17/07/2020.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import MBProgressHUD
extension UIViewController{
    func setBackgroundColor(){
        self.view.backgroundColor = .init(red: 233.0/255.0, green: 37.0/255.0, blue: 41.0/255.0, alpha: 1.0)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func registerKeyboardNotification(){
        if (UIDevice.isScreen35inch() || UIDevice.isScreen4inch()) {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    func removeObserver(){
        if (UIDevice.isScreen35inch() || UIDevice.isScreen4inch()) {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

//MARK: - LoginVC Extension
extension LoginVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == self.userName){
            self.password.becomeFirstResponder()
            return false
        }
        self.login()
        self.view.endEditing(true)
        return false
    }
    
    func sendLoginRequest(){
        if Utilities.isConnectedToNetwork(){
            MBProgressHUD.showAdded(to: self.view, animated: true)
            ViewModel.shared.performLogin(userName: self.userName.text!, password: self.password.text!, onSuccess: {[unowned self] (success) in
                DispatchQueue.main.async {
                    if(success){
                        self.showItemDetailVC()}
                    else{
                        Utilities.showAlert(Utilities.alert, message:Utilities.unauthorizedAccess)}
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }) { (error) in
                DispatchQueue.main.async {
                    Utilities.showAlert(Utilities.alert, message: error.debugDescription)
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
        }else{
            Utilities.showAlert(Utilities.alert, message:Utilities.networkConnectionError)
        }
        
    }
    
   private func showItemDetailVC(){
        let itemDetailObj = self.storyboard?.instantiateViewController(identifier: "ItemDetailVC") as! ItemDetailVC
        self.navigationController?.pushViewController(itemDetailObj, animated: true)
        
    }
}

//MARK: - ItemDetailVC Extension
extension ItemDetailVC{
    func fetchItems(){
        if Utilities.isConnectedToNetwork(){
            MBProgressHUD.showAdded(to: self.view, animated: true)
            ViewModel.shared.fetchItemList(onSuccess: {[unowned self] (success) in
                DispatchQueue.main.async {
                    if(success){
                        self.showItemListVC()
                    }else{
                        Utilities.showAlert(Utilities.alert, message: Utilities.errorFetchingData)
                    }
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }) { (error) in
                DispatchQueue.main.async {
                    Utilities.showAlert(Utilities.alert, message: error.debugDescription)
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
        }else{
            Utilities.showAlert(Utilities.alert, message: Utilities.networkConnectionError)
        }
    }
    
   private func showItemListVC(){
        let itemListVC = self.storyboard?.instantiateViewController(identifier: "ItemsListVC")
        self.navigationController?.pushViewController(itemListVC!, animated: true)
    }
}

//MARK: - ItemsListVC Extension
extension ItemsListVC:UITableViewDelegate,UITableViewDataSource{
    // MARK: - TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModel.shared.getItemsList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = ViewModel.shared.getItemsList()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ItemCell
        cell.renderCellInfo(item: item)
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
}
