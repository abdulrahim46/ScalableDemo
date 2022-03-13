//
//  NetworkManager.swift
//  ScalableDemo
//
//  Created by Abdul Rahim on 10/03/22.
//

import Foundation
import Network
import UIKit

class NetworkManager: DataProvider {
    
    /// custom error for apis
    enum CustomError: Error {
        case invalidUrl
        case invalidData
    }
    
    let networkMonitor = NWPathMonitor()
    
    /// generic request for all apis
    func request<T: Codable>(urlName: ServiceURLType, expecting: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        if !checkNetwork() {
            return
        }
        
        let urlString = URLManager.getUrlString(for: urlName)
        let completeUrl = URL(string: urlString)
        guard let url = completeUrl else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            self?.networkMonitor.cancel()
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
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
        
        task.resume()
        
    }
    
    // Checking the network connection before making requests
    private func checkNetwork() -> Bool {
        var status = true
        networkMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                status = true
                // show something for expensive path from mobile network
            } else {
                status = false
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Warning!", message: "You do not have internet at the moment...", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        networkMonitor.start(queue: queue)
        
        return status
    }
}
