//
//  OpahUsersListDefinitions.swift
//  OpahGit
//
//  Created by Thiago Santiago on 23/05/21.
//

import Foundation

struct OpahUsersListDefinitions {
    
    struct Strings {
        static let viewTitle = "Lista de usuários"
        static let errorTitle = "Oops!"
    }
    
    struct Ints {
        static let cellHeight: Int = 80
    }
}

struct UserDto {
    let userId: Int
    let imageUrl: String
    let login: String
}
