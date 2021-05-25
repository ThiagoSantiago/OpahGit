//
//  OpahUsersListPresenterTests.swift
//  OpahGitTests
//
//  Created by Thiago Santiago on 24/05/21.
//

import XCTest
@testable import OpahGit

final class OpahUserListViewControllerMock: OpahUsersListDisplaying {
    private(set) var didLoadView = 0
    private(set) var didShowUserList = 0
    private(set) var didShowFooterView = 0
    private(set) var didHideFooterView = 0
    private(set) var didshowError = 0
    private(set) var userList: [UserDto] = []
    private(set) var errorMessage = ""
    
    func loadView(isLoading: Bool) {
        didLoadView += 1
    }
    
    func showUsersList(list: [UserDto]) {
        didShowUserList += 1
        userList = list
    }
    
    func showFooterView() {
        didShowFooterView += 1
    }
    
    func hideFooterView() {
        didHideFooterView += 1
    }
    
    func showError(message: String) {
        didshowError += 1
        errorMessage = message
    }
}


final class OpahUsersListPresenterTests: XCTestCase {
    private let viewControllerMock = OpahUserListViewControllerMock()
    private lazy var sut: OpahUsersListPresenter = {
        let presenter = OpahUsersListPresenter()
        presenter.viewController = viewControllerMock
        
        return presenter
    }()
    
    
    func testPresentLoading() {
        sut.presentLoading(isLoading: true)
        
        XCTAssertEqual(viewControllerMock.didLoadView, 1)
    }
    
    func testPresentUsersList() {
        let userList = getUserListMock()
        sut.presentUsersList(users: userList)
        
        XCTAssertEqual(viewControllerMock.didShowUserList, 1)
        XCTAssertEqual(viewControllerMock.userList.count, 3)
        XCTAssertEqual(viewControllerMock.userList[0].login, "mojombo")
        XCTAssertEqual(viewControllerMock.userList[1].userId, 2)
        XCTAssertEqual(viewControllerMock.userList[2].login, "defunkt")
    }
    
    func testPresentError() {
        sut.presentError(error: OpahApiError.badUrl)
        
        XCTAssertEqual(viewControllerMock.didshowError, 1)
        XCTAssertEqual(viewControllerMock.errorMessage, "Bad URL request")
    }
    
    func testPresentFooterLoading() {
        sut.presentFooterLoading()
        
        XCTAssertEqual(viewControllerMock.didShowFooterView, 1)
    }
    
    func testRemoveFooterLoading() {
        sut.removeFooterLoading()
        
        XCTAssertEqual(viewControllerMock.didHideFooterView, 1)
    }
    
    private func getUserListMock() -> UsersList {
        let user1 = User(login: "mojombo",
                         id: 1,
                         nodeId: "MDQ6VXNlcjE=",
                         avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4",
                         gravatarId: "",
                         url: "",
                         htmlUrl: "",
                         followersUrl: "",
                         followingUrl: "",
                         gistsUrl: "",
                         starredUrl: "",
                         subscriptionsUrl: "",
                         organizationsUrl: "",
                         reposUrl: "",
                         eventsUrl: "",
                         receivedEventsUrl: "",
                         type: "",
                         siteAdmin: false)
        
        let user2 = User(login: "pjhyett",
                         id: 2,
                         nodeId: "MDQ6VXNlcjM=",
                         avatarUrl: "https://avatars.githubusercontent.com/u/3?v=4",
                         gravatarId: "",
                         url: "",
                         htmlUrl: "",
                         followersUrl: "",
                         followingUrl: "",
                         gistsUrl: "",
                         starredUrl: "",
                         subscriptionsUrl: "",
                         organizationsUrl: "",
                         reposUrl: "",
                         eventsUrl: "",
                         receivedEventsUrl: "",
                         type: "",
                         siteAdmin: false)
        
        let user3 = User(login: "defunkt",
                         id: 3,
                         nodeId: "MDQ6VXNlcjI=",
                         avatarUrl: "https://avatars.githubusercontent.com/u/2?v=4",
                         gravatarId: "",
                         url: "",
                         htmlUrl: "",
                         followersUrl: "",
                         followingUrl: "",
                         gistsUrl: "",
                         starredUrl: "",
                         subscriptionsUrl: "",
                         organizationsUrl: "",
                         reposUrl: "",
                         eventsUrl: "",
                         receivedEventsUrl: "",
                         type: "",
                         siteAdmin: false)
        
        return [user1, user2, user3]
    }
}
