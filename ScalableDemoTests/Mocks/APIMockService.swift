//
//  APIMockService.swift
//  ScalableDemoTests
//
//  Created by Abdul Rahim on 13/03/22.
//

import XCTest
@testable import ScalableDemo

class APIMockService: DataProvider {
    
    func request<T>(urlName: ServiceURLType, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        
        var urlString = URLManager.getUrlString(for: urlName)
        if urlString.contains("commits") {
            urlString = "commits"
        } else {
            urlString = "repo"
        }
        
        guard let url = Bundle(for: APIMockService.self).url(forResource: urlString, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode(expecting, from: data)
            completion(.success(result))
        }
        catch {
            completion(.failure(error))
        }
    }
    


}
