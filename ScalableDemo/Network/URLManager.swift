//
//  URLManager.swift
//  ScalableDemo
//
//  Created by Abdul Rahim on 10/03/22.
//

import Foundation


struct URLManager {
    
    static let kBaseURL = "https://api.github.com"
    
    static func getUrlString(for serviceEnum: ServiceURLType)-> String {
        switch serviceEnum {
        case .repos:
            return kBaseURL + "/users/mralexgray/repos"
        case .commits(let name):
            return kBaseURL + "/users/mralexgray/" + name
        }
    }
    
}


enum ServiceURLType {
    case repos
    case commits(String)
}
