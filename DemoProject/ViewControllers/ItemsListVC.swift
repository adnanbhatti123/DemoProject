//
//  ItemsListVC.swift
//  DemoProject
//
//  Created by APPLE on 17/07/2020.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class ItemsListVC: BaseViewController {
    @IBOutlet weak var tableView:UITableView!
    let cellIdentifier = "ItemCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showHeaderTitleAndDescription(title: Utilities.itemslistScreenTitle, description: "")
        // Do any additional setup after loading the view.
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
