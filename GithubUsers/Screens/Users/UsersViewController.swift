//
//  UsersViewController.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/3/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import UIKit

final class UsersViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel = UsersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        getData()
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
    
    func getData() {
        viewModel.getData { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
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
}
