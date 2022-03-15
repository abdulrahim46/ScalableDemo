//
//  CommitsViewModelTests.swift
//  ScalableDemoTests
//
//  Created by Abdul Rahim on 15/03/22.
//

import XCTest
@testable import ScalableDemo

class CommitsViewModelTests: XCTestCase {

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
    
    
    func test_fetch_commits_view_model() {
        let mock = APIMockService()
        let viewModel = CommitsViewModel(apiResource: mock)
        
        let promise = expectation(description: "loading data count...")
        
        viewModel.getCommits(user: "-REPONAME", completion: { response, err  in
            if let res = response {
                XCTAssertEqual(res.count, 29)
                XCTAssertEqual(res.first?.sha, "498856beeaf3510079a4ac832125fcb2a713794d")
                XCTAssertNotNil(res, "Commits should not be nil")
                promise.fulfill()
            } else {
                XCTAssertNotNil(err, "Error should be nil")
                XCTFail()
            }
        })
        wait(for: [promise], timeout: 1)
    }

}
