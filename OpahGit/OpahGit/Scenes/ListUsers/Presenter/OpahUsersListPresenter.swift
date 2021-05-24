//
//  OpahUsersListPresenter.swift
//  OpahGit
//
//  Created by Thiago Santiago on 23/05/21.
//

import Foundation

protocol OpahUsersListPresenting: AnyObject {
    var viewController: OpahUsersListDisplaying? { get set }
    func presentUsersList(users: UsersList)
    func presentLoading(isLoading: Bool)
    func presentError(error: OpahApiError)
    func presentFooterLoading()
    func removeFooterLoading()
    func presentUserDetails(name: String)
}

final class OpahUsersListPresenter: OpahUsersListPresenting {
    weak var viewController: OpahUsersListDisplaying?
    
    func presentUsersList(users: UsersList) {
        let list = users.map {
            UserDto(userId: $0.id,
                    imageUrl: $0.avatarUrl,
                    login: $0.login) }
        viewController?.showUsersList(list: list)
    }
    
    func presentLoading(isLoading: Bool) {
        viewController?.loadView(isLoading: isLoading)
    }
    
    func presentError(error: OpahApiError) {
        viewController?.showError(message: error.localizedDescription)
    }
    
    func presentFooterLoading() {
        viewController?.showFooterView()
    }
    
    func removeFooterLoading() {
        viewController?.hideFooterView()
    }
    
    func presentUserDetails(name: String) {
        AppRouter.shared.routeToUserDetails(name: name)
    }
}
