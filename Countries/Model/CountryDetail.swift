//
//  CountryDetail.swift
//  Countries
//
//  Created by user on 3/8/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation


class CountryDetail {
    var country: [ModelKey:String]? = [ModelKey:String]()
    var currencies: [Currencies]? = [Currencies]()
    var languages : [Languages]? = [Languages]()
    var callingCodes: String?
    var timezones: String?
    var flagImageData: Data?
}
