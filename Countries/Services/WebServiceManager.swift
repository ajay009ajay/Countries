//
//  WebServiceManager.swift
//  Countries
//
//  Created by user on 3/6/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation

import Foundation

class WebServiceManager {
    
    private let session: URLSession
    
    // By using a default argument (in this case .shared) we can add dependency
    // injection without making our app code more complicated.
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getCountryListBySearchText(searchText: String, completion: @escaping ([CountryDetail]?, Error?)->()) {
        
        let urlString = "\(HTTPUrl.country_search_url)\(searchText)"
        debugPrint("UrlString = \(urlString)")
        guard let url = URL(string: urlString) else { return }
        session.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            
            if error != nil || data == nil {
                completion(nil,error)
                debugPrint("Client error!")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                debugPrint("Server error!")
                completion(nil,CustomError.httpResponseError)
                return
            }
            
            guard let data = data else {
                completion(nil, CustomError.dataError)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let countryArr: [CountryModel] = try decoder.decode([CountryModel].self, from: data)
                
                let countryDetailObjArr = ResponseFormatter.init().getCountryDetailFormattedData(countryModels: countryArr)
                    
                completion(countryDetailObjArr,nil)
            } catch {
                debugPrint("JSON error: \(error.localizedDescription)")
                completion(nil,CustomError.jsonDecoingError)
            }
        }.resume()
    }
    
    func getFlagImageData(flagUrl: String, completion: @escaping (Data?, Error?)->()) {
        
        let url = URL(string: flagUrl)
        self.session.dataTask(with: URLRequest(url: url!)) { (data, response, error) in
            
            if error != nil || data == nil {
                completion(nil,error)
                debugPrint("Client error!")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                debugPrint("Server error!")
                
                completion(nil,CustomError.httpResponseError)
                return
            }
            
            guard let data = data else {
                completion(nil, CustomError.dataError)
                return
            }
            
            if let receivedData = String(bytes: data, encoding:  String.Encoding.utf8) {
                completion(Data(receivedData.utf8),nil)
            }
            }.resume()
    }
}
//
//extension URLSessionMock  {
//    override func dataTask(
//        with url: URL,
//        completionHandler: @escaping CompletionHandler
//        ) -> URLSessionDataTask {
//        let data = self.data
//        let error = self.error
//        
//        return URLSessionDataTaskMock {
//            completionHandler(data, nil, error)
//        }
//    }
//}
