//
//  RepoViewModel.swift
//  ScalableDemo
//
//  Created by Abdul Rahim on 13/03/22.
//

import Foundation

protocol RepoViewProtocol: AnyObject {
    func reloadTableView()
}

class RepoViewModel {
    
    var repos: [Repo]?
    var apiResource: DataProvider
    weak var view: RepoViewProtocol?
    
    init(apiResource: DataProvider = NetworkManager()) {
        self.apiResource = apiResource
    }
    
    /// Get repos for specific user
    
    func getRepos() {
        apiResource.request(urlName: .repos, expecting: [Repo].self, completion: { [weak self] result in
            switch result {
            case .success(let repo):
                self?.repos = repo
                DispatchQueue.main.async {
                    self?.view?.reloadTableView()
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    ///Number of rows for items  count in table view
    
    var numberOfRows: Int {
        return repos?.count ?? 0
    }
    
    ///get  items for particular index  in table view
    
    func getRepo(index: Int) -> Repo? {
        return repos?[index]
    }
    
}
