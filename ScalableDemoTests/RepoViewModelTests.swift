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
    
    func testFetchCommits() {
        
        let mock = APIMockService()
        
        let promise = expectation(description: "loading data count...")
        
        mock.request(urlName: .commits("-REPONAME"), expecting: [Commits].self, completion: { response in
            switch response {
            case .success(let commit):
                XCTAssertEqual(commit.count, 29)
                XCTAssertEqual(commit.first?.sha, "498856beeaf3510079a4ac832125fcb2a713794d")
                promise.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error, "Error should be nil")
                XCTFail()
            }
        })
        wait(for: [promise], timeout: 1)
    }

}
