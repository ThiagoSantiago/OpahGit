//
//  OpahUserDetailsPresenterTests.swift
//  OpahGitTests
//
//  Created by Thiago Santiago on 24/05/21.
//

import XCTest
@testable import OpahGit

final class OpahUserDetailViewControllerMock: OpahUserDetailsDisplaying {
    private(set) var didShowLoadView = 0
    private(set) var didShowUserReposList = 0
    private(set) var didShowError = 0
    private(set) var didShowUserDetails = 0
    private(set) var userDetails: UserDetailDto?
    private(set) var userRepoList: [RepoDto]?
    private(set) var errorMessage: String?
    
    
    func loadView(isLoading: Bool) {
        didShowLoadView += 1
    }
    
    func showUserReposList(list: [RepoDto]) {
        didShowUserReposList += 1
        userRepoList = list
    }
    
    func showError(message: String) {
        didShowError += 1
        errorMessage = message
    }
    
    func displayUserDetails(userDetail: UserDetailDto) {
        didShowUserDetails += 1
        userDetails = userDetail
    }
}

final class OpahUserDetailsPresenterTests: XCTestCase {
    private let viewControllerMock = OpahUserDetailViewControllerMock()
    private lazy var sut: OpahUserDetailsPresenter = {
        let presenter = OpahUserDetailsPresenter()
        presenter.viewController = viewControllerMock
        
        return presenter
    }()
    
    func testPresentLoading() {
        sut.presentLoading(isLoading: true)
        
        XCTAssertEqual(viewControllerMock.didShowLoadView, 1)
    }
    
    func testPresentError() {
        sut.presentError(error: OpahApiError.brokenData)
        
        XCTAssertEqual(viewControllerMock.didShowError, 1)
        XCTAssertEqual(viewControllerMock.errorMessage, "The received data is broken.")
    }
    
    func testPresentReposList() {
        let repoList = getUserRepoList()
        sut.presentReposList(repos: repoList)
        
        XCTAssertEqual(viewControllerMock.didShowUserReposList, 1)
        XCTAssertNotNil(viewControllerMock.userRepoList)
        XCTAssertEqual(viewControllerMock.userRepoList?.count, 3)
        XCTAssertEqual(viewControllerMock.userRepoList?[0].name, "libdc-for-dirk")
        XCTAssertEqual(viewControllerMock.userRepoList?[1].fullName, "torvalds/linux")
        XCTAssertEqual(viewControllerMock.userRepoList?[2].description, "Brother PES file converter")
    }
    
    func testPresentUserDetail() {
        let user = UserDetail(id: 1024025,
                              login: "torvalds",
                              name: "Linus Torvalds",
                              avatarUrl: "https://avatars.githubusercontent.com/u/1024025?v=4",
                              company: "Linux Foundation",
                              location: "Portland, OR",
                              email: nil)
        
        sut.presentUserDetail(user: user)
        
        XCTAssertEqual(viewControllerMock.didShowUserDetails, 1)
        XCTAssertNotNil(viewControllerMock.userDetails)
        XCTAssertEqual(viewControllerMock.userDetails?.name, user.name)
        XCTAssertEqual(viewControllerMock.userDetails?.company, user.company)
        XCTAssertEqual(viewControllerMock.userDetails?.location, user.location)
    }
    
    private func getUserRepoList() -> UserReposList {
        let repo1 = UserRepos(id: 79171906,
                              name: "libdc-for-dirk",
                              fullName: "torvalds/libdc-for-dirk",
                              description: "Only use for syncing with Dirk, don't use for anything else")
        
        let repo2 = UserRepos(id: 2325298,
                              name: "linux",
                              fullName: "torvalds/linux",
                              description: "Linux kernel source tree")
        
        let repo3 = UserRepos(id: 113099837,
                              name: "pesconvert",
                              fullName: "torvalds/pesconvert",
                              description: "Brother PES file converter")
        
        return [repo1, repo2, repo3]
    }
}
