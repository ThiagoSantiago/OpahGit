//
//  OpahUserListServiceSetup.swift
//  OpahGit
//
//  Created by Thiago Santiago on 23/05/21.
//

import Foundation

enum OpahUsersListServiceSetup: OpahApiSetupProtocol {
    
    case getUsers(page: Int)
    
    var endpoint: String {
        switch self {
        
        case let .getUsers(page):
            let url = Constants.baseUrl+"/users?page=\(page)&per_page=100"
            
            return url
        }
    }
    
    var headers: [String : String] {
        return ["Content-Type":"application/json"]
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        }
    }
}
