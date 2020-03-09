//
//  ResponseFormatter.swift
//  Countries
//
//  Created by user on 3/8/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation

struct ResponseFormatter {
    
    func getCountryDetailFormattedData(countryModels:[CountryModel]) -> [CountryDetail] {
        var arr = [CountryDetail]()
        
        for eachModelObj in countryModels {
            let eachCountry = CountryDetail()
            
            eachCountry.country?[.name] = eachModelObj.name
            eachCountry.country?[.flag] = eachModelObj.flag
            eachCountry.country?[.capital] = eachModelObj.capital
            eachCountry.country?[.region] = eachModelObj.region
            eachCountry.country?[.subregion] = eachModelObj.subregion
            
            if let codeArr = eachModelObj.callingCodes, codeArr.count > 0 {
                eachCountry.callingCodes = codeArr[0]
            }
            if let timeZoneArr = eachModelObj.timezones, timeZoneArr.count > 0 {
                eachCountry.timezones = timeZoneArr[0]
            }
            eachCountry.currencies = eachModelObj.currencies
            eachCountry.languages = eachModelObj.languages

            arr.append(eachCountry)
        }
        
        return arr
    }
}
