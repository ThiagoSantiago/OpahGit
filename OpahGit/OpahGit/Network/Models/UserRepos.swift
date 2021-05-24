//
//  UserRepos.swift
//  OpahGit
//
//  Created by Thiago Santiago on 24/05/21.
//

import Foundation

struct UserRepos: Codable {
    let id: Int
    let name, fullName: String
    let userRepoPrivate: Bool
    let language: String?
}

typealias UserReposList = [UserRepos]
