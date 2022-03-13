//
//  RepoViewModel.swift
//  ScalableDemo
//
//  Created by Abdul Rahim on 13/03/22.
//

import Foundation

class RepoViewModel {
    
    
    var repos: [Repo]?
    var apiResource: DataProvider
    
    init(apiResource: DataProvider = NetworkManager()) {
        self.apiResource = apiResource
    }
    
    func getRepos(completion: @escaping ([Repo]?,Error?) -> Void) {
        apiResource.request(urlName: .repos, expecting: [Repo].self, completion: { [weak self] result in
            
            switch result {
            case .success(let repo):
                completion(repo, nil)
                self?.repos = repo
            case .failure(let error):
                completion(nil,error)
            }
        })
    }
    
    
    func getRepoCount() -> Int {
        return repos?.count ?? 0
    }
    
    func getRepo(index: Int) -> Repo? {
        return repos?[index]
    }
    
}
