//
//  CountryViewModel.swift
//  Countries
//
//  Created by user on 3/6/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
import UIKit
 
class CountryViewModel:NSObject {
    
    private let countryWebService: WebServiceManager

    var countries: Box<[CountryDetail]?> = Box(nil)
    var savedCountriesArr = [CountryDetail]()

    init(countryWebService: WebServiceManager) {
        self.countryWebService = countryWebService
    }
}

extension CountryViewModel {
    
    func getCountryListBySearchText(searchText: String) {
        
        if searchText.count <= 0 {
            countries.value?.removeAll()
            savedCountriesArr.removeAll()
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let reachability = appDelegate.reachability
        let savedArr = DatabaseHelper.sharedInstance.fetchSavedCountryData()
        let filteredArr: [CountryDetail] = savedArr.filter { (($0.country?[ModelKey.name] ?? "").contains(searchText))}

        if !(reachability.connection == .unavailable) {
            countryWebService.getCountryListBySearchText(searchText: searchText) { [weak self] (countryData, error) in
                self?.countries.value = countryData
                self?.savedCountriesArr = filteredArr
            }
        } else {
             countries.value = filteredArr
             savedCountriesArr = filteredArr
        }
    }
}

extension CountryViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell", for: indexPath) as! CountryListTableViewCell
        
        if let counteryData = countries.value?[indexPath.row]{
            cell.drawCell(countryDetail: counteryData,delegateContext: self,savedData: savedCountriesArr)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.countries.value?.count {
            return count
        }
        return 0
    }
}

extension CountryViewModel: OfflineSaveDelegate {
    func savedToDisk(flagUrl: String?, flagImageData: Data?) {
        let savedCountryModel: CountryDetail? = countries.value?.filter{($0.country?[ModelKey.flag]) == flagUrl}.first

        if let savedCountryModel = savedCountryModel {
            DatabaseHelper.sharedInstance.saveCountryDetail(coutryDetail: savedCountryModel, flagImageData: flagImageData)
            savedCountriesArr.append(savedCountryModel)
        }
    }
    func updateSoureForCachedFlagImagedata(flagUrl: String?, flagImageData: Data?) {
        let detailObj: CountryDetail? = countries.value?.filter{($0.country?[ModelKey.flag]) == flagUrl}.first
        detailObj?.flagImageData = flagImageData
    }
}
