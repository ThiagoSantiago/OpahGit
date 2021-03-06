//
//  OpahUsersListView.swift
//  OpahGit
//
//  Created by Thiago Santiago on 23/05/21.
//

import Foundation
import UIKit

protocol OpahUsersListDisplaying: AnyObject {
    func loadView(isLoading: Bool)
    func showUsersList(list: [UserDto])
    func showFooterView()
    func hideFooterView()
    func showError(message: String)
}

final class OpahUsersListView: BaseViewController {
   
    // MARK: - Alias
    
    typealias Strings = OpahUsersListDefinitions.Strings
    typealias Ints = OpahUsersListDefinitions.Ints
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView?
    
    // MARK: - Private properties
    
    private var usersList: [UserDto] = []
    private let interactor: OpahUsersListInteracting
    private let loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    // MARK: - Lifecycle
    
    init(interactor: OpahUsersListInteracting) {
        self.interactor = interactor
        super.init(nibName: "OpahUsersListView", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.resetPages()
        interactor.loadData()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = Strings.viewTitle
    }
    
    private func configView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: "OpahUserListItemTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "OpahUserListItemTableViewCell")
        
        searchBar?.delegate = self
        searchBar?.showsCancelButton = true
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: view.layer.bounds.width, height: 50))
        
        loader.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        loader.center = customView.center
        loader.stopAnimating()
        customView.addSubview(loader)
        tableView?.tableFooterView = customView
    }
}

// MARK: - OpahUsersListDisplaying

extension OpahUsersListView: OpahUsersListDisplaying {
    func loadView(isLoading: Bool) {
        isLoading ? showLoader() : hideLoader()
    }
    
    func showUsersList(list: [UserDto]) {
        usersList = list
        tableView?.reloadData()
    }
    
    func showFooterView() {
        loader.startAnimating()
    }
    
    func hideFooterView() {
        loader.stopAnimating()
    }
    
    func showError(message: String) {
        showError(title: Strings.errorTitle, message: message)
    }
}

// MARK: - UITableViewDelegate / DataSource

extension OpahUsersListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OpahUserListItemTableViewCell", for: indexPath) as? OpahUserListItemTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setContent(user: usersList[indexPath.row])
    
        if indexPath.row == usersList.count - 1 && !interactor.isSearching {
            interactor.getNextPage()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.showUserDetail(userName: usersList[indexPath.row].login)
        hideKeyboard()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Ints.cellHeight)
    }
}

extension OpahUsersListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor.searchUser(name: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        hideKeyboard()
    }
    
    func hideKeyboard() {
        interactor.stopSearching()
        searchBar?.resignFirstResponder()
    }
}
