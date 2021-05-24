//
//  AppRouter.swift
//  OpahGit
//
//  Created by Thiago Santiago on 23/05/21.
//

import UIKit

class AppRouter {
    
    static let shared = AppRouter()
    
    var navigation: UINavigationController = UINavigationController()
    
    func routeToUsersList() {
        let viewController = OpahUsersListFactory.make()
        self.navigation.pushViewController(viewController, animated: false)
    }
    
    func routeToUserDetails(name: String) {
        let viewController = OpahUserDetailsFactory.make(userName: name)
        self.navigation.pushViewController(viewController, animated: true)
    }
}
