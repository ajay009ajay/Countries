//
//  CountriesListControllerTests.swift
//  CountriesTests
//
//  Created by user on 3/9/20.
//  Copyright © 2020 user. All rights reserved.
//

import XCTest
@testable import Countries

class CountriesListControllerTests: XCTestCase {

    var countriesVC: CountryListViewController!
    var mockSession = URLSessionMock()
    var webManager: WebServiceManager?
    var vm: CountryViewModel?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: CountryListViewController = storyboard.instantiateViewController(withIdentifier: "CountryListViewController") as! CountryListViewController
        countriesVC = vc
        countriesVC.loadView()
        
        webManager = WebServiceManager(session: mockSession)
        
        if let webManager = webManager {
            vm = CountryViewModel(countryWebService: webManager)

        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    private func getJsonFileData(fileName: String)-> Data? {
        
        var jsonData: Data?

        if let filepath = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let url = URL(fileURLWithPath: filepath)
                
                do {
                    jsonData = try?Data(contentsOf: url)
                }
            }
        }
        return jsonData
    }
    
    func testCountryListData()  {
        
        let mockCountryDetail = CountryDetail()
        mockCountryDetail.country = [ModelKey.name: "India"]
        mockCountryDetail.currencies = [Currencies(name: "India", code: "INR", symbol: "INR")]
        mockCountryDetail.languages = [Languages(iso639_1: "iso_1", iso639_2: "iso_2", name: "Hindi", nativeName: "Hindi")]
        mockCountryDetail.flagImageData = nil
        mockCountryDetail.callingCodes = "+91"
        
       DatabaseHelper.sharedInstance.saveCountryDetail(coutryDetail: mockCountryDetail, flagImageData: nil)
        
        let cachedDataArr = DatabaseHelper.sharedInstance.fetchSavedCountryData()
        
        XCTAssertTrue(cachedDataArr.count > 0, "Cached Array count shoud more than one")

        mockSession.data = getJsonFileData(fileName: "India")

        vm?.getCountryListBySearchText(searchText: "India")
        
        let expection = expectation(description: "country")

        vm?.countries.bind {(data) in
            expection.fulfill()
        }
        
        waitForExpectations(timeout: 10) { [weak self] (error) in
            
            if let vm = self?.vm, let countryArr = vm.countries.value {
                XCTAssertTrue(countryArr.count > 0, "Array count shoud more than one")
                self?.countriesVC.countryTableView.reloadData()
            }
        }
    }

}
