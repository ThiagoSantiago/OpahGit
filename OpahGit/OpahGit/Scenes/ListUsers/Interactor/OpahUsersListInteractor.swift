//
//  OpahUsersListInteractor.swift
//  OpahGit
//
//  Created by Thiago Santiago on 23/05/21.
//

import Foundation

protocol OpahUsersListInteracting: AnyObject {
    var isSearching: Bool { get }
    func loadData()
    func getNextPage()
    func resetPages()
    func stopSearching()
    func searchUser(name: String)
}

final class OpahUsersListInteractor: OpahUsersListInteracting {
    var isSearching = false
    
    private let presenter: OpahUsersListPresenting
    private var currentPage = 1
    private var showFooterLoad = false
    private var usersList: UsersList = []
    
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
                    let list = try decoder.decode(UsersList.self, from: data)
                    self.usersList.append(contentsOf: list)
                    DispatchQueue.main.async {
                        self.presenter.presentUsersList(users: self.usersList)
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
    
    func searchUser(name: String) {
        isSearching = true
        if name.isEmpty {
            presenter.presentUsersList(users: usersList)
        } else {
            let filteredList = usersList.filter { $0.login.uppercased().contains(name.uppercased()) }
            presenter.presentUsersList(users: filteredList)
        }
    }
    
    func stopSearching() {
        isSearching = false
        presenter.presentUsersList(users: usersList)
    }
}
