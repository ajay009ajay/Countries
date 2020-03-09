//
//  CountryCellViewModel.swift
//  Countries
//
//  Created by user on 3/7/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation

protocol OfflineSaveDelegate:class {
    func savedToDisk(flagUrl: String?, flagImageData: Data?)
    func updateSoureForCachedFlagImagedata(flagUrl: String?, flagImageData: Data?)
}

class CountryCellViewModel {
    
    var flagImageData: Box<Data?> = Box(nil)
    private let imageFetchService: WebServiceManager
    
    private(set) var flagUrl: String?

    init(imageFetchService: WebServiceManager) {
        self.imageFetchService = imageFetchService
    }
}

extension CountryCellViewModel {
    func getFlagImageData(url: String)  {
        imageFetchService.getFlagImageData(flagUrl: url) {[weak self] (data, error) in
            self?.flagImageData.value = data
            self?.flagUrl = url
        }
    }
}
