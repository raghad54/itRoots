//
//  DataListViewController.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 04/06/2025.
//


import UIKit
import Network

class PostsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noConnectionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!


    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    private let viewModel = PostsViewModel()

    private let offlineData: [Post] = [
        Post(userId: 1, id: 0, title: "Offline Title 1", body: "Offline body text A"),
        Post(userId: 2, id: 1, title: "Offline Title 2", body: "Offline body text B"),
        Post(userId: 3, id: 2, title: "Offline Title 3", body: "Offline body text C")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNib()
        tableView.dataSource = self
        noConnectionLabel.isHidden = true
        activityIndicator.hidesWhenStopped = true

        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self?.noConnectionLabel.isHidden = true
                    self?.loadOnlineData()
                } else {
                    self?.noConnectionLabel.isHidden = false
                    self?.loadOfflineData()
                }
            }
        }

        monitor.start(queue: queue)
    }
    
    private func setupNib() {
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }

    private func loadOnlineData() {
        activityIndicator.startAnimating()
        viewModel.fetchPosts { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.tableView.reloadData()
        }
    }

    private func loadOfflineData() {
        activityIndicator.stopAnimating()
        viewModel.posts = offlineData
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = viewModel.posts[indexPath.row]
        cell.configure(post: post)
        return cell
    }
}
