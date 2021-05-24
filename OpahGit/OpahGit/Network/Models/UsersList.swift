//
//  UsersList.swift
//  OpahGit
//
//  Created by Thiago Santiago on 23/05/21.
//

import Foundation

struct User: Codable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let gravatarId: String
    let url, htmlUrl, followersUrl: String
    let followingUrl, gistsUrl, starredUrl: String
    let subscriptionsUrl, organizationsUrl, reposUrl: String
    let eventsUrl: String
    let receivedEventsUrl: String
    let type: String
    let siteAdmin: Bool
}

typealias UsersList = [User]
