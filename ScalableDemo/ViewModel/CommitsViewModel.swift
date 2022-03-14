//
//  CommitsViewModel.swift
//  ScalableDemo
//
//  Created by Abdul Rahim on 13/03/22.
//

import Foundation

class CommitsViewModel {
    
    var commits: [Commits]?
    var apiResource: DataProvider
    
    init(apiResource: DataProvider = NetworkManager()) {
        self.apiResource = apiResource
    }
    
    // MARK: Fetch commits for specific repo
    
    func getCommits(user: String, completion: @escaping ([Commits]?,Error?) -> Void) {
        /// using group of asynchronous operations
        let group = DispatchGroup()
        group.enter()
        
        apiResource.request(urlName: .commits(user), expecting: [Commits].self, completion: { [weak self] result in
            switch result {
            case .success(let commit):
                completion(commit, nil)
                group.leave()
                self?.commits = commit
            case .failure(let error):
                group.leave()
                completion(nil,error)
            }
        })
    }
}
