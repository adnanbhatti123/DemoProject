//
//  TextField+ValidationCheck.swift
//  DemoProject
//
//  Created by APPLE on 17/07/2020.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

extension UITextField{
    func checkIfNotEmpty() -> Bool{
        if (self.text!.isEmpty){
            return false
        }
        return true
    }
}
