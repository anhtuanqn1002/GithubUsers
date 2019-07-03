//
//  UsersViewController.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit
import MBProgressHUD
import SVPullToRefresh

final class UsersViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel = UsersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupPullToRefresh()
        getData()
        bindData()
    }
}

// MARK: - Private
private extension UsersViewController {
    func setupUI() {
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar() {
        title = viewModel.title
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: UsersTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: UsersTableViewCell.reuseIdentifier)
    }
    
    func bindData() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                MBProgressHUD.showAdded(to: self.view, animated: true)
            } else {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.tableView.pullToRefreshView.stopAnimating()
            }
        }
    }
    
    func setupPullToRefresh() {
        tableView.addPullToRefresh { [weak self] in
            guard let self = self else { return }
            self.getData()
        }
    }
    
    func getData() {
        viewModel.getData { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func showDetailsAt(_ indexPath: IndexPath) {
        guard let detailsViewController = DetailsViewController.instantiateFromStoryboard(),
            let detailsViewModel = viewModel.createDetailsViewModel(indexPath.row)
            else { return }
        detailsViewController.viewModel = detailsViewModel
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.reuseIdentifier, for: indexPath) as! UsersTableViewCell
        cell.displayCell(viewModel.cellViewModelAt(indexPath.row))
        return cell
    }
}

// MARK: - UITableViewDelegate
extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showDetailsAt(indexPath)
    }
}
