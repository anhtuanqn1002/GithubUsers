//
//  DetailsViewController.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit
import MBProgressHUD

final class DetailsViewController: UIViewController {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var bioLabel: UILabel!
    @IBOutlet private weak var publicRepoNumberLabel: UILabel!
    @IBOutlet private weak var followersNumberLabel: UILabel!
    @IBOutlet private weak var followingNumberLabel: UILabel!
    
    var viewModel: DetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindData()
        getData()
    }
}

// MARK: - Private
private extension DetailsViewController {
    func setupUI() {
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        title = viewModel.title
    }
    
    func bindData() {
        viewModel.isLoading.bindAndFire { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                MBProgressHUD.showAdded(to: self.view, animated: true)
            } else {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
    
    func getData() {
        viewModel.getUserDetails { [weak self] in
            guard let self = self else { return }
            self.updateUI()
        }
    }
    
    func updateUI() {
        avatarImageView.load(viewModel.avatarString)
        usernameLabel.text = viewModel.username
        locationLabel.text = viewModel.location
        bioLabel.text = viewModel.bio
        publicRepoNumberLabel.text = viewModel.publicRepo
        followersNumberLabel.text = viewModel.followers
        followingNumberLabel.text = viewModel.following
    }
}

// MARK: - LoadableFromStoryboard
extension DetailsViewController: LoadableFromStoryboard {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
