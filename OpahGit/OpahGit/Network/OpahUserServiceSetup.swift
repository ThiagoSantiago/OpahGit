//
//  OpahUserServiceSetup.swift
//  OpahGit
//
//  Created by Thiago Santiago on 23/05/21.
//

import Foundation

enum OpahUserServiceSetup: OpahApiSetupProtocol {
    
    case getUser(name: String)
    
    var endpoint: String {
        switch self {
            
        case let .getUser(name):
            let url = Constants.baseUrl+"/users/\(name)"
            
            return url
        }
    }
    
    var headers: [String : String] {
        return ["Content-Type":"application/json"]
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUser:
            return .get
        }
    }
}
