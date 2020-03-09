//
//  CountryDetailsViewModel.swift
//  Countries
//
//  Created by user on 3/7/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
import UIKit

class CountryDetailsViewModel: NSObject {
    
    private (set) var countryModelObj: CountryDetail
    private var commonKeys = [ModelKey]()
    
    init(countryModelObj: CountryDetail) {
        self.countryModelObj = countryModelObj
        
        if let allKeys = countryModelObj.country?.keys {
            commonKeys = Array(allKeys).filter{$0 != ModelKey.flag}
            commonKeys.append(ModelKey.callingCodes)
            commonKeys.append(ModelKey.timezones)
            commonKeys = commonKeys.sorted{ $0.rawValue  <=  $1.rawValue }
        }
    }
}

extension CountryDetailsViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        if section >= 2 {
            return 1
        }
        return commonKeys.count
    }
    
    private func tableViewForCommonCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonTableViewCell", for: indexPath) as! CommonTableViewCell
        
        cell.selectionStyle = .none
        
        switch commonKeys[indexPath.row] {
        case ModelKey.name:
            cell.drawCell(title: TableViewCellName.country.rawValue, value: countryModelObj.country?[ModelKey.name])
        case ModelKey.capital:
            cell.drawCell(title: TableViewCellName.capital.rawValue, value: countryModelObj.country?[ModelKey.capital])
        case ModelKey.callingCodes:
            cell.drawCell(title: TableViewCellName.callingCodes.rawValue, value: countryModelObj.callingCodes) //todo
        case ModelKey.region:
            cell.drawCell(title: TableViewCellName.region.rawValue, value: countryModelObj.country?[ModelKey.region])
        case ModelKey.subregion:
            cell.drawCell(title: TableViewCellName.subRegion.rawValue, value: countryModelObj.country?[ModelKey.subregion])
        case ModelKey.timezones:
            cell.drawCell(title: TableViewCellName.timeZone.rawValue, value: countryModelObj.timezones) //todo
        default:
            print("No Action")
            
        }
        return cell
    }
    
    private func tableViewForLanguageCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell", for: indexPath) as! LanguageTableViewCell
        
        if let languageData = countryModelObj.languages, languageData.count > 0 {
            var langObj = Languages()
            langObj.iso639_1 = languageData[0].iso639_1
            langObj.iso639_2 = languageData[0].iso639_2
            langObj.name = languageData[0].name
            langObj.nativeName = languageData[0].nativeName
            
            cell.drawCell(language: langObj)
        }
        return cell
    }
    
    private func tableViewForCurrencyCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for: indexPath) as! CurrencyTableViewCell
        
        if let currencyData = countryModelObj.currencies, currencyData.count > 0 {
            var obj = Currencies()
            obj.name = currencyData[0].name
            obj.code = currencyData[0].code
            obj.symbol = currencyData[0].symbol

            cell.drawCell(currencyDetail: obj)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            return tableViewForCommonCell(tableView, cellForRowAt: indexPath)
        } else if indexPath.section == 2{
            return tableViewForLanguageCell(tableView, cellForRowAt: indexPath)
        } else {
            return tableViewForCurrencyCell(tableView, cellForRowAt: indexPath)
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var headerText = ""
        if section == 1 {
            headerText = TableViewHeaderName.about.rawValue
        } else if (section == 2) {
            headerText = TableViewHeaderName.language.rawValue
        } else if (section == 3) {
            headerText = TableViewHeaderName.currency.rawValue
        }
        return headerText
    }
}
