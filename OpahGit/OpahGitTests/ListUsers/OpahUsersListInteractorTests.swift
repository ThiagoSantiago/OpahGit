//
//  OpahUsersListInteractorTests.swift
//  OpahGitTests
//
//  Created by Thiago Santiago on 24/05/21.
//

import XCTest
@testable import OpahGit

final class OpahUsersListPresenterMock: OpahUsersListPresenting {
    var viewController: OpahUsersListDisplaying?
    private(set) var didPresentUserList = 0
    private(set) var didPresentLoading = 0
    private(set) var didPresentError = 0
    private(set) var didPresentFooterLoading = 0
    private(set) var didRemoveFooterLoading = 0
    private(set) var didPresentUserDetails = 0
    private(set) var usersList: UsersList?
    private(set) var userName: String?
    
    func presentUsersList(users: UsersList) {
        didPresentUserList += 1
        usersList = users
    }
    
    func presentLoading(isLoading: Bool) {
        didPresentLoading += 1
    }
    
    func presentError(error: OpahApiError) {
        didPresentError += 1
    }
    
    func presentFooterLoading() {
        didPresentFooterLoading += 1
    }
    
    func removeFooterLoading() {
        didRemoveFooterLoading += 1
    }
    
    func presentUserDetails(name: String) {
        didPresentUserDetails += 1
        userName = name
    }
}

final class OpahUsersListInteractorTests: XCTestCase {
    private let presenterMock = OpahUsersListPresenterMock()
    private lazy var sut: OpahUsersListInteractor = {
        let interactor = OpahUsersListInteractor(presenter: presenterMock)
        return interactor
    }()
    
    func testShowUserDetail() {
        sut.showUserDetail(userName: "mojombo")
        
        XCTAssertEqual(presenterMock.didPresentUserDetails, 1)
    }
    
    func testStopSearching() {
        sut.searchUser(name: "mojombo")
        XCTAssertTrue(sut.isSearching)
            
        sut.stopSearching()
        XCTAssertFalse(sut.isSearching)
    }
}
