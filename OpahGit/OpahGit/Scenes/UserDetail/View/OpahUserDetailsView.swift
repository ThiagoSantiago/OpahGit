//
//  OpahUserDetailsView.swift
//  OpahGit
//
//  Created by Thiago Santiago on 23/05/21.
//

import Foundation
import UIKit

protocol OpahUserDetailsDisplaying: AnyObject {
    func loadView(isLoading: Bool)
    func showUserReposList(list: [RepoDto])
    func showError(message: String)
    func displayUserDetails(userDetail: UserDetailDto)
}

final class OpahUserDetailsView: BaseViewController {
    
    typealias Strings = OpahUserDetailsDefinitions.Strings
    
    // MARK: - Outlets
    
    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var userCompanyLabel: UILabel?
    @IBOutlet weak var userLocationLabel: UILabel?
    @IBOutlet weak var useremailLabel: UILabel?
    @IBOutlet weak var userImage: UIImageView?
    @IBOutlet weak var tableView: UITableView?
    
    // MARK: - Private properties
    
    private var userRepoList: [RepoDto] = []
    private let interactor: OpahUserDetailsInteracting
    
    // MARK: - Lifecycle
    
    init(interactor: OpahUserDetailsInteracting) {
        self.interactor = interactor
        super.init(nibName: "OpahUserDetailsView", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
}

// MARK: - OpahUserDetailsDisplaying

extension OpahUserDetailsView: OpahUserDetailsDisplaying {
    func loadView(isLoading: Bool) {
        isLoading ? showLoader() : hideLoader()
    }
    
    func showUserReposList(list: [RepoDto]) {
        userRepoList = list
        tableView?.reloadData()
    }
    
    func showError(message: String) {
        showError(title: Strings.errorTitle, message: message)
    }
    
    func displayUserDetails(userDetail: UserDetailDto) {
        userNameLabel?.text = userDetail.name
        userCompanyLabel?.text = "Company: \(userDetail.company)"
        userLocationLabel?.text = "Location: \(userDetail.location)"
        useremailLabel?.text = "Email: \(userDetail.email)"
    }
}

// MARK: - UITableViewDelegate / DataSource

extension OpahUserDetailsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userRepoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = userRepoList[indexPath.row].name
        return cell
    }
}
