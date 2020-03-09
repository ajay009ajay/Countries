//
//  LanguageTableViewCell.swift
//  Countries
//
//  Created by user on 3/8/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

 
class LanguageTableViewCell: UITableViewCell {

    @IBOutlet weak var iso6391Lbl: UILabel!
    @IBOutlet weak var iso6392Lbl: UILabel!
    @IBOutlet weak var languageNameLbl: UILabel!
    @IBOutlet weak var nativeLanguageLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func drawCell(language: Languages) {
        iso6391Lbl.text = language.iso639_1
        iso6392Lbl.text = language.iso639_2
        languageNameLbl.text = language.name
        nativeLanguageLbl.text = language.nativeName
    }

}
