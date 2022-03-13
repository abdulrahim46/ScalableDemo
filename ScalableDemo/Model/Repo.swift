//
//  Repo.swift
//  ScalableDemo
//
//  Created by Abdul Rahim on 13/03/22.
//

import Foundation

struct Repo: Codable {
    let name: String?
    let forks: Int?
    let stars: Int?
    let language: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case forks = "forks"
        case stars = "stargazers_count"
        case language = "language"
        case description = "description"
    }
}
