//
//  TestDetailsViewModel.swift
//  GithubUsersTests
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import XCTest
@testable import GithubUsers

class TestDetailsViewModel: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFollowingNumberIsTrue() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = XCTestExpectation(description: "detailsViewModel")
        let user = User()
        let viewModel = DetailsViewModel(user: user, apiManager: MockUserAPI())
        viewModel.getUserDetails {
            XCTAssertEqual(viewModel.followers.value, "10", "Followers number must be 10")
            XCTAssertEqual(viewModel.following.value, "22", "Following number must be 22")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutInterval)
    }
}
