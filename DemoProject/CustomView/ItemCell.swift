//
//  ItemCell.swift
//  DemoProject
//
//  Created by APPLE on 17/07/2020.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    @IBOutlet weak var priceLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func renderCellInfo(item:Item){
        nameLabel.text = ViewModel.shared.getName(item: item)
        descriptionLabel.text = ViewModel.shared.getDescription(item: item)
        priceLabel.text = ViewModel.shared.getPrice(item: item)
    }

}
