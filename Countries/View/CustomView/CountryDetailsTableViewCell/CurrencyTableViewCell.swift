//
//  CurrencyTableViewCell.swift
//  Countries
//
//  Created by user on 3/8/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyCodeLbl: UILabel!
    @IBOutlet weak var currencyNameLbl: UILabel!
    @IBOutlet weak var currencySymbolLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func drawCell(currencyDetail: Currencies)  {
        currencyCodeLbl.text = currencyDetail.code
        currencyNameLbl.text = currencyDetail.name
        currencySymbolLbl.text = currencyDetail.symbol
    }

}
