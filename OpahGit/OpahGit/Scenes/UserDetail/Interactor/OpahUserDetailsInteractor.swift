//
//  OpahUserDetailsInteractor.swift
//  OpahGit
//
//  Created by Thiago Santiago on 23/05/21.
//

import Foundation

protocol OpahUserDetailsInteracting: AnyObject {
    func loadData()
}

final class OpahUserDetailsInteractor: OpahUserDetailsInteracting {
    
    private let userName: String
    private let presenter: OpahUserDetailsPresenting
    
    init(userName: String, presenter: OpahUserDetailsPresenting) {
        self.userName = userName
        self.presenter = presenter
    }
    
    func loadData() {
        requestUserDetails()
        requestUserRepos()
    }
    
    private func requestUserDetails() {
        presenter.presentLoading(isLoading: true)
        OpahApiRequest().request(OpahUserServiceSetup.getUser(name: userName)) { [weak self] result in
            guard let self = self else { return }
            self.presenter.presentLoading(isLoading: false)
            
            switch result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let user = try decoder.decode(UserDetail.self, from: data)
                    DispatchQueue.main.async {
                        self.presenter.presentUserDetail(user: user)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.presenter.presentError(error: .couldNotParseObject)
                    }
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self.presenter.presentError(error: error)
                }
            }
        }
    }
    
    private func requestUserRepos() {
        OpahApiRequest().request(OpahUserReposServiceSetup.getUserRepos(name: userName)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let reposList = try decoder.decode(UserReposList.self, from: data)
                    DispatchQueue.main.async {
                        self.presenter.presentReposList(repos: reposList)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.presenter.presentError(error: .couldNotParseObject)
                    }
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self.presenter.presentError(error: error)
                }
            }
        }
    }
}
