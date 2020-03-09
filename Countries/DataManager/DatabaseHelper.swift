//
//  DatabaseHelper.swift
//  Countries
//
//  Created by user on 3/7/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
import CoreData

class DatabaseHelper {
    // MARK: - Core Data stack
    
    static let sharedInstance = DatabaseHelper()
    
    private init () {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Countries")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveCountryDetail(coutryDetail: CountryDetail, flagImageData: Data?) {
        let manageObjectContext = persistentContainer.viewContext
        
        let country =  NSEntityDescription.insertNewObject(forEntityName: "Country", into: manageObjectContext) as? Country
        
        if let currencies = coutryDetail.currencies {
            for eachCurrency in currencies {
                let currency =  NSEntityDescription.insertNewObject(forEntityName: "Currency", into: manageObjectContext) as? Currency
                currency?.code = eachCurrency.code
                currency?.name = eachCurrency.name
                currency?.symbol = eachCurrency.symbol
                
                currency?.addToCountries(country!)

            }
        }
        
        if let languages = coutryDetail.languages {
            for eachLanguage in languages {
                let language = NSEntityDescription.insertNewObject(forEntityName: "Language", into: manageObjectContext) as? Language
                language?.iso639_1 = eachLanguage.iso639_1
                language?.iso639_2 = eachLanguage.iso639_2
                language?.name = eachLanguage.name
                language?.nativeName = eachLanguage.nativeName
                
                language?.addToCountries(country!)
            }
        }
        country?.name = coutryDetail.country?[.name]
        country?.flag = coutryDetail.country?[.flag]
        country?.region = coutryDetail.country?[.region]
        country?.subregion = coutryDetail.country?[.subregion]
        country?.capital = coutryDetail.country?[.capital]
        country?.callingCodes = coutryDetail.callingCodes
        country?.timezones =  coutryDetail.timezones
        
        country?.flagImageData = flagImageData
 
        saveContext()
     }
    
    func fetchSavedCountryData()-> [CountryDetail] {
        var savedCoutries = [CountryDetail]()
        
        let manageObjectContext = persistentContainer.viewContext
        
        let request:NSFetchRequest<Country> = Country.fetchRequest()
 
        do {
            let result = try manageObjectContext.fetch(request)
            
            for countryObj in result {
                
                let obj = CountryDetail()
                
                obj.country?[ModelKey.name] = countryObj.name //data.value(forKey: "name") as? String
                obj.country?[ModelKey.flag] = countryObj.flag //data.value(forKey: "flag") as? String
                obj.country?[ModelKey.capital] = countryObj.capital //data.value(forKey: "capital") as? String
                obj.country?[ModelKey.region] = countryObj.region //data.value(forKey: "region") as? String
                obj.country?[ModelKey.subregion] = countryObj.subregion//data.value(forKey: "subregion") as? String
                obj.flagImageData =  countryObj.flagImageData //data.value(forKey: "flagImageData") as? Data
                
                obj.callingCodes = countryObj.callingCodes //data.value(forKey: "callingCodes") as? [String]
                
                var currArr = [Currencies]()
                if let currencySet = countryObj.currencies, let currenciesArr = Array(currencySet) as? [Currency]  {
                    for eachCurrency in currenciesArr {
                        var currency = Currencies()
                        currency.code = eachCurrency.code
                        currency.name = eachCurrency.name
                        currency.symbol = eachCurrency.symbol
                        currArr.append(currency)
                    }
                }
                obj.currencies = currArr
                
                var langArr = [Languages]()
                if let langSet = countryObj.languages, let languagesArr = Array(langSet) as? [Language]  {
                    for eachLang in languagesArr {
                        var langObj = Languages()
                        langObj.iso639_1 = eachLang.iso639_1
                        langObj.iso639_2 = eachLang.iso639_2
                        langObj.name = eachLang.name
                        langObj.nativeName = eachLang.nativeName
                        
                        langArr.append(langObj)
                    }
                }
                obj.languages = langArr
                
//                let currency = Array(countryObj.currencies)
                //data.value(forKey: "country_currency") as? [Currencies]
//                let langs = countryObj.languages //data.value(forKey: "country_language") as? [Languages]

//                let currency =  NSEntityDescription.insertNewObject(forEntityName: "EntityCurrencies", into: manageObjectContext) as? EntityCurrencies
                
//                var langArr = [Languages]()
//                
//                if let languagesEntityArr = data.value(forKey: "languages") as? [EntityLanguages] {
//                    for eachLang in languagesEntityArr {
//                        var lang = Languages()
//                        lang.iso639_1 = eachLang.iso639_1
//                        langArr.append(lang)
//                    }
//                }
//
//                for eachLang in (data.value(forKey: "languages") as? [EntityLanguages])! {
//
//                }
//                obj.languages = data.value(forKey: "languages") as? [EntityLanguages]
//                obj.currencies = data.value(forKey: "currencies") as? [EntityCurrencies]

                
                savedCoutries.append(obj)
            }
            
        } catch {
            print("Failed to fetch")
        }
        return savedCoutries
    }
}
