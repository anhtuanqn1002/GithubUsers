//
//  DetailsViewController.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit
import MBProgressHUD
import SVPullToRefresh

final class DetailsViewController: UIViewController {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var bioLabel: UILabel!
    @IBOutlet private weak var publicRepoNumberLabel: UILabel!
    @IBOutlet private weak var followersNumberLabel: UILabel!
    @IBOutlet private weak var followingNumberLabel: UILabel!
    
    var viewModel: DetailsViewModel!
    
    @IBOutlet weak var scrollView: UIScrollView!
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
        setupPullToRefresh()
    }
    
    func setupPullToRefresh() {
        scrollView.addPullToRefresh { [weak self] in
            guard let self = self else { return }
            self.getData()
        }
    }
    
    func bindData() {
        viewModel.isLoading.bindAndFire { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                MBProgressHUD.showAdded(to: self.view, animated: true)
            } else {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.scrollView.pullToRefreshView.stopAnimating()
            }
        }
        
        viewModel.title.bindAndFire { [weak self] title in
            guard let self = self else { return }
            self.title = title
        }
        
        viewModel.avatarString.bindAndFire { [weak self] avatar in
            guard let self = self else { return }
            self.avatarImageView.load(avatar)
        }
        
        viewModel.username.bindAndFire { [weak self] username in
            guard let self = self else { return }
            self.usernameLabel.text = username
        }
        
        viewModel.location.bindAndFire { [weak self] location in
            guard let self = self else { return }
            self.locationLabel.text = location
        }
        
        viewModel.bio.bindAndFire { [weak self] bio in
            guard let self = self else { return }
            self.bioLabel.text = bio
        }
        
        viewModel.publicRepo.bindAndFire { [weak self] publicRepo in
            guard let self = self else { return }
            self.publicRepoNumberLabel.text = publicRepo
        }
        
        viewModel.followers.bindAndFire { [weak self] followers in
            guard let self = self else { return }
            self.followersNumberLabel.text = followers
        }
        
        viewModel.following.bindAndFire { [weak self] following in
            guard let self = self else { return }
            self.followingNumberLabel.text = following
        }
    }
    
    func getData() {
        viewModel.getUserDetails()
    }
}

// MARK: - LoadableFromStoryboard
extension DetailsViewController: LoadableFromStoryboard {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
