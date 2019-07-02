//
//  UsersTableViewCell.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit

final class UsersTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var loginLabel: UILabel!
    @IBOutlet private weak var htmlURLLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayCell(_ viewModel: UsersCellViewModel?) {
        guard let viewModel = viewModel else { return }
        avatarImageView.load(viewModel.avatarURLString)
        loginLabel.text = viewModel.login
        htmlURLLabel.text = viewModel.htmlURL
    }
}
