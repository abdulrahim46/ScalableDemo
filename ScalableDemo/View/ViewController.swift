//
//  ViewController.swift
//  ScalableDemo
//
//  Created by Abdul Rahim on 10/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel: RepoViewModel
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(viewModel: RepoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Github Repo"
        setupTableView()
        
        viewModel.getRepos(completion: { [weak self] repo, err in
            //self?.repo = repo
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
    //MARK: - UI Setup
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // register tableView cells
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: RepoTableViewCell.identifier)
        
        // constraints
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRepoCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.identifier, for: indexPath) as? RepoTableViewCell else {
            fatalError("Repo cell is not implemented")
        }
        guard let repo = viewModel.getRepo(index: indexPath.row) else {
            print("Repo data is not found!")
            return UITableViewCell()
        }
        cell.configureCell(repo: repo)
        cell.configureCommit(repo: repo, vm: CommitsViewModel())
        return cell
        
    }
    
    
}

