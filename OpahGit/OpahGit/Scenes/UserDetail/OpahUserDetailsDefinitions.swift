//
//  OpahUserDetailsDefinitions.swift
//  OpahGit
//
//  Created by Thiago Santiago on 24/05/21.
//

import Foundation

struct OpahUserDetailsDefinitions {
    
    struct Strings {
        static let viewTitle = "Detalhes do usuário"
        static let errorTitle = "Oops!"
    }
}

struct RepoDto {
    let name: String
    let fullName: String
    let description: String
}

struct UserDetailDto {
    let name: String
    let company: String
    let location: String
    let email: String
    let imageUrl: String
}
