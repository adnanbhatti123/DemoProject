//
//  ViewController.swift
//  DemoProject
//
//  Created by APPLE on 16/07/2020.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
class LoginVC: MainViewController {
    @IBOutlet weak var userName:UITextField!
    @IBOutlet weak var password:UITextField!
    @IBOutlet weak var loginBtn:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showHeaderTitleAndDescription(title: Utilities.loginScreenTitle, description: "")
    }
    
    //MARK: - IBAction Method
    @IBAction func login(){
        if(self.userName.checkIfNotEmpty() && self.password.checkIfNotEmpty()){
            sendLoginRequest()
            return
        }
        Utilities.showAlert(Utilities.alert, message: Utilities.textFieldValidationMessage)
    }
}

