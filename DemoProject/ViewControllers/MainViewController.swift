//
//  MainViewController.swift
//  DemoProject
//
//  Created by APPLE on 16/07/2020.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var headerView:HeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setBackgroundColor()
        registerKeyboardNotification()
    }
    
    func showHeaderTitleAndDescription(title:String, description:String){
        headerView.setTitleAndUsernameText(title: title, description: description)
    }
    
    deinit {
        removeObserver()
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
