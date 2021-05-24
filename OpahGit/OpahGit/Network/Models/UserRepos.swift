//
//  UserRepos.swift
//  OpahGit
//
//  Created by Thiago Santiago on 24/05/21.
//

import Foundation

struct UserRepos: Codable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
}

typealias UserReposList = [UserRepos]
