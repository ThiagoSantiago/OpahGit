//
//  OpahUserReposPresenter.swift
//  OpahGit
//
//  Created by Thiago Santiago on 24/05/21.
//

import Foundation

protocol OpahUserDetailsPresenting: AnyObject {
    var viewController: OpahUserDetailsDisplaying? { get set }
    func presentReposList(repos: UserReposList)
    func presentLoading(isLoading: Bool)
    func presentError(error: OpahApiError)
}

final class OpahUserDetailsPresenter: OpahUserDetailsPresenting {
    weak var viewController: OpahUserDetailsDisplaying?
    
    func presentReposList(repos: UserReposList) {
        viewController?.showUserReposList(list: [])
    }
    
    func presentLoading(isLoading: Bool) {
        viewController?.loadView(isLoading: isLoading)
    }
    
    func presentError(error: OpahApiError) {
        viewController?.showError(message: error.localizedDescription)
    }
}
