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
    
    func getCommits(user: String, completion: @escaping ([Commits]?,Error?) -> Void) {
        apiResource.request(urlName: .commits(user), expecting: [Commits].self, completion: { [weak self] result in
            switch result {
            case .success(let commit):
                completion(commit, nil)
                print(commit)
                self?.commits = commit
            case .failure(let error):
                //print(error)
                completion(nil,error)
               // AlertBuilder.failureAlertWithMessage(message: error.localizedDescription)
            }
        })
    }
}
