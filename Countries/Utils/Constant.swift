//
//  Constant.swift
//  Countries
//
//  Created by user on 3/6/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
import UIKit

enum ModelKey: String{
    case name
    case flag
    case capital
    case region
    case subregion
    case callingCodes
    case timezones
//    case currencies
//    case languages
//    
//    //
//    case flagImageData
}

enum HTTPUrl {
    static let country_search_url = "https://restcountries.eu/rest/v2/name/"
}

enum CustomError: Error {
    case httpResponseError
    case jsonDecoingError
    case dataError
}

enum TableViewConstant {
    static let flagSectionHeight: CGFloat = 225
    static let countryAboutSecionHeight: CGFloat = 160
    static let commonSectionHeight: CGFloat = 70
    /* header */
    static let flagSectionHeaderHeight: CGFloat = 200

}

enum TableViewHeaderName: String {
    case about = "About"
    case language = "Language"
    case currency = "Currency"
}

enum TableViewCellName: String {
    case country = "Country"
    case capital = "Capital"
    case callingCodes = "Calling Codes"
    case region = "Region"
    case subRegion = "Subregion"
    case timeZone = "Time Zone"
}
