//
//  OpahUserListItemTableViewCell.swift
//  OpahGit
//
//  Created by Thiago Santiago on 24/05/21.
//

import UIKit

class OpahUserListItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView?
    @IBOutlet weak var userNameLabel: UILabel?
    
    func setContent(user: UserDto) {
        userNameLabel?.text = user.login
    }
}
