//
//  TestUsersViewModel.swift
//  GithubUsersTests
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import XCTest
@testable import GithubUsers

class TestUsersViewModel: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumberOfUserLoadedSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = XCTestExpectation(description: "userViewModel")
        let viewModel = UsersViewModel(apiManager: MockUserAPI())
        viewModel.getData {
            XCTAssertEqual(viewModel.numberOfCell, 1, "Total users must be 1")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutInterval)
    }
}
