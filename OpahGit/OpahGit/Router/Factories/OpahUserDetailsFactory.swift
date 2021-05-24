//
//  OpahUserDetailsFactory.swift
//  OpahGit
//
//  Created by Thiago Santiago on 24/05/21.
//

import Foundation

final class OpahUserDetailsFactory {
    static func make(userName: String) -> OpahUserDetailsView {
        let presenter = OpahUserDetailsPresenter()
        let interactor = OpahUserDetailsInteractor(userName: userName, presenter: presenter)
        let viewController = OpahUserDetailsView(interactor: interactor)
        presenter.viewController = viewController
        
        return viewController
    }
}
