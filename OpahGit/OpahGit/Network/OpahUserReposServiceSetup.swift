//
//  OpahUserReposServiceSetup.swift
//  OpahGit
//
//  Created by Thiago Santiago on 23/05/21.
//

import Foundation

enum OpahUserReposServiceSetup: OpahApiSetupProtocol {
    
    case getUserRepos(name: String)
    
    var endpoint: String {
        switch self {
            
        case let .getUserRepos(name):
            let url = Constants.baseUrl+"/users/\(name)\repos"
            
            return url
        }
    }
    
    var headers: [String : String] {
        return ["Content-Type":"application/json"]
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUserRepos:
            return .get
        }
    }
}
