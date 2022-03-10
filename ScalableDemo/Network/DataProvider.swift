//
//  DataProvider.swift
//  ScalableDemo
//
//  Created by Abdul Rahim on 10/03/22.
//

import Foundation

protocol DataProvider {
    func request<T: Codable>(urlName: ServiceURLType, expecting: T.Type, completion: @escaping(Result<T, Error>) -> Void)
}
