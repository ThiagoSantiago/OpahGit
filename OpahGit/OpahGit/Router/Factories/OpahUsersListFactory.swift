//
//  OpahUsersListFactory.swift
//  OpahGit
//
//  Created by Thiago Santiago on 23/05/21.
//

import Foundation

final class OpahUsersListFactory {
    static func make() -> OpahUsersListView {
        let presenter = OpahUsersListPresenter()
        let interactor = OpahUsersListInteractor(presenter: presenter)
        let viewController = OpahUsersListView(interactor: interactor)
        presenter.viewController = viewController
        
        return viewController
    }
}
