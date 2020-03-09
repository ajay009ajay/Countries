//
//  CountryListTableViewCell.swift
//  Countries
//
//  Created by user on 3/6/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import SVGKit

//protocol FlagImageFetchComplitionDelegate:class {
//    func flagImageFetchCompleted(flagImageData: Data?)
//}

class CountryListTableViewCell: UITableViewCell {

    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var offlineLbl: UILabel!
    
    @IBOutlet weak var svgImageView: SVGKFastImageView!
    private var cellViewModel = CountryCellViewModel(imageFetchService: WebServiceManager())
    weak private var offlineSaveDelegate : OfflineSaveDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellViewModel.flagImageData.bind { [weak self] (data) in
            if let receivedData = data {
                DispatchQueue.main.async {
                    let anSVGImage: SVGKImage = SVGKImage(data: receivedData)
                    self?.svgImageView.image = anSVGImage
                    
                     if self?.offlineSaveDelegate != nil {
                        self?.offlineSaveDelegate?.updateSoureForCachedFlagImagedata(flagUrl: self?.cellViewModel.flagUrl, flagImageData: receivedData)
                    }
                }
            }
        }
        saveButton.isHidden = true
    }
    @IBAction func saveBtnClicked(_ sender: Any) {

        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.offlineLbl.isHidden = false
        }
        
        if offlineSaveDelegate != nil {
            offlineSaveDelegate?.savedToDisk(flagUrl: cellViewModel.flagUrl,flagImageData: cellViewModel.flagImageData.value)
        }
        saveButton.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func drawCell(countryDetail: CountryDetail, delegateContext: OfflineSaveDelegate?, savedData: [CountryDetail])  {
        
        self.countryName.text = countryDetail.country?[ModelKey.name]  //todo
        offlineSaveDelegate = delegateContext
        var isSaved = false
        
        let countryOfflineData: CountryDetail? = savedData.filter{($0.country?[.flag]) == (countryDetail.country?[.flag])}.first
        
        if let countryOfflineData = countryOfflineData {
             isSaved = true
            cellViewModel.flagImageData.value = countryOfflineData.flagImageData
        }
        
        if let flagUrl =  countryDetail.country?[.flag], !isSaved{
            cellViewModel.getFlagImageData(url: flagUrl)
        }
        
        self.offlineLbl.isHidden = !isSaved
        self.saveButton.isHidden = isSaved
    }
}
