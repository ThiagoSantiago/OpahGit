//
//  OpahUserListServiceSetup.swift
//  OpahGit
//
//  Created by Thiago Santiago on 23/05/21.
//

import Foundation

enum OpahUsersListServiceSetup: OpahApiSetupProtocol {
    
    case getUsers
    
    var endpoint: String {
        switch self {
            
        case .getUsers:
            let url = Constants.baseUrl+"/users"
            
            return url
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        }
    }
}
