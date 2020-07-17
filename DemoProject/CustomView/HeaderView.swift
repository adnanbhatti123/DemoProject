//
//  HeaderView.swift
//  DemoProject
//
//  Created by APPLE on 16/07/2020.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    @IBOutlet private weak var titleLabel:UILabel!
    @IBOutlet private weak var userName:UILabel!
    let nibName = "HeaderView"
    var contentView: UIView?
    
    // MARK: - Initialize View
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib() else { return }
        titleLabel = (view.viewWithTag(1) as! UILabel)
        userName = (view.viewWithTag(2) as! UILabel)
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    // MARK: - Custom Functions
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setTitleAndUsernameText(title:String, description:String){
        self.titleLabel.text = title
        self.userName.text = description
    }
    
    
}
