//
//  CountryModel.swift
//  Countries
//
//  Created by user on 3/6/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation

struct CountryModel: Codable {
    var name: String?
    var flag: String?
    var capital: String?
    var region: String?
    var subregion: String?
    var callingCodes: [String]?
    var timezones: [String]?
    var currencies: [Currencies]?
    var languages: [Languages]?
}

struct Currencies: Codable {
    var name: String?
    var code: String?
    var symbol: String?
}

struct Languages: Codable {
    var iso639_1: String?
    var iso639_2: String?
    var name: String?
    var nativeName: String?
}


