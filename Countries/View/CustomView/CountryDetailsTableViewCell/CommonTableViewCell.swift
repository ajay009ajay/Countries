//
//  CommonTableViewCell.swift
//  Countries
//
//  Created by user on 3/8/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class CommonTableViewCell: UITableViewCell {
    @IBOutlet weak var countryAttributeLbl: UILabel!
    @IBOutlet weak var countryAttributeValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func drawCell(title: String, value: String?) {
        countryAttributeLbl.text = title
        
        if let value = value {
            countryAttributeValue.text = value
        }
    }
    
}
