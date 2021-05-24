//
//  User.swift
//  OpahGit
//
//  Created by Thiago Santiago on 24/05/21.
//

import Foundation

struct UserDetail: Codable {
    let id: Int
    let login: String
    let name: String?
    let avatarUrl: String?
    let company: String?
    let location: String?
    let email: String?
}
