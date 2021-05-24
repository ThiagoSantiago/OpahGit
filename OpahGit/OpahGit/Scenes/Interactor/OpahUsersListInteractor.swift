//
//  OpahUsersListInteractor.swift
//  OpahGit
//
//  Created by Thiago Santiago on 23/05/21.
//

import Foundation

protocol OpahUsersListInteracting: AnyObject {
    func loadData()
    func getNextPage()
    func resetPages()
}

final class OpahUsersListInteractor: OpahUsersListInteracting {
    private let presenter: OpahUsersListPresenting
    private var currentPage = 1
    private var showFooterLoad = false
    
    init(presenter: OpahUsersListPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        if showFooterLoad {
            self.presenter.presentFooterLoading()
        } else {
            self.presenter.presentLoading(isLoading: true)
        }
        
        OpahApiRequest().request(OpahUsersListServiceSetup.getUsers(page: currentPage)) { [weak self] result in
            guard let self = self else { return }
            
            if self.showFooterLoad {
                self.presenter.removeFooterLoading()
            } else {
                self.presenter.presentLoading(isLoading: false)
            }
            
            switch result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let usersList = try decoder.decode(UsersList.self, from: data)
                    DispatchQueue.main.async {
                        self.presenter.presentUsersList(users: usersList)
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
    
    func getNextPage() {
        showFooterLoad = true
        currentPage += 1
        loadData()
    }
    
    func resetPages() {
        showFooterLoad = false
        currentPage = 1
    }
}
