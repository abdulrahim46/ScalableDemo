//
//  RepoViewModelTests.swift
//  ScalableDemoTests
//
//  Created by Abdul Rahim on 13/03/22.
//

import XCTest
@testable import ScalableDemo

class RepoViewModelTests: XCTestCase {
    

    func testInitialization() {
        let dataProvider = NetworkManager()

        // Initialize repo View Model
        let repoViewModel = RepoViewModel(apiResource: dataProvider)
        XCTAssertNotNil(repoViewModel, "The repo view model should not be nil.")
    }
    
    
    func testFetchRepos() {
        
        let mock = APIMockService()

        let promise = expectation(description: "loading data count...")
        
        mock.request(urlName: .repos, expecting: [Repo].self, completion: { response in
            print(response)
            switch response {
            case .success(let repo):
                XCTAssertEqual(repo.count, 30)
                
                promise.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error, "Error not nil")
                XCTFail()
            }
        })
        wait(for: [promise], timeout: 1)
    }
    
    func test_fetch_repo_view_model() {
        let mock = APIMockService()
        let viewModel = RepoViewModel(apiResource: mock)

        viewModel.getRepos()
        XCTAssertEqual(viewModel.numberOfRows, 30)
        XCTAssertNotNil(viewModel.repos, "repos should not be nil")
        XCTAssertEqual(viewModel.getRepo(index: 0)?.stars, 0)
    }

}
