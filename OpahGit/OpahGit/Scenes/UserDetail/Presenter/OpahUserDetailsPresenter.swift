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
    func presentUserDetail(user: UserDetail)
}

final class OpahUserDetailsPresenter: OpahUserDetailsPresenting {
    weak var viewController: OpahUserDetailsDisplaying?
    
    func presentReposList(repos: UserReposList) {
        let repoList = repos.map { RepoDto(name: $0.name,
                                           fullName: $0.fullName,
                                           description: $0.description ?? "")
        }
        viewController?.showUserReposList(list: repoList)
    }
    
    func presentLoading(isLoading: Bool) {
        viewController?.loadView(isLoading: isLoading)
    }
    
    func presentError(error: OpahApiError) {
        viewController?.showError(message: error.localizedDescription)
    }
    
    func presentUserDetail(user: UserDetail) {
        let userDetrail = UserDetailDto(name: user.name ?? "Not informed",
                                        company: user.company ?? "Not informed",
                                        location: user.location ?? "Not informed",
                                        email: user.email ?? "Not informed",
                                        imageUrl: user.avatarUrl ?? "Not informed")
        
        viewController?.displayUserDetails(userDetail: userDetrail)
    }
}
