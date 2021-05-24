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
    func showUserReposList(list: [UserDto])
    func showError(message: String)
}

final class OpahUserDetailsView: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var userImage: UIImageView?
    @IBOutlet weak var tableView: UITableView?
    
    // MARK: - Private properties
    
    private var usersList: [UserDto] = []
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
        interactor.loadData()
    }
}

extension OpahUserDetailsView: OpahUserDetailsDisplaying {
    func loadView(isLoading: Bool) {
        isLoading ? showLoader() : hideLoader()
    }
    
    func showUserReposList(list: [UserDto]) {
        usersList = list
    }
    
    func showError(message: String) {
        showError(title: "Oops!", message: message)
    }
}
