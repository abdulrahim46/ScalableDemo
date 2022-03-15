//
//  RepoTableViewCell.swift
//  ScalableDemo
//
//  Created by Abdul Rahim on 12/03/22.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    
    //MARK:- Properties & Views
    
    static let identifier = "RepoTableViewCell"
    
    lazy var containerView: ShadowView = {
        let view = ShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var repoNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var lastCommitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 1
        return label
    }()

    
    lazy var starLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var forkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var langLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starLabel, forkLabel, langLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.contentMode = .scaleToFill
        stackView.clipsToBounds = false
        return stackView
    }()

    //MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    
    func setupViews() {
        setupContainerView()
        setupLabels()
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    
    private func setupLabels() {
        
        [repoNameLabel, descriptionLabel, lastCommitLabel, stackView].forEach {
            containerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            repoNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            repoNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            repoNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            lastCommitLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            lastCommitLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            lastCommitLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            stackView.topAnchor.constraint(equalTo: lastCommitLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }


    
    //MARK: - Actions
    
    func configureCell(repo: Repo) {
        repoNameLabel.text = repo.name ?? "Not found"
        descriptionLabel.text = repo.description ?? "Not Found"
        starLabel.text = "Stars: " + String(repo.stars ?? 0)
        forkLabel.text = "Fork: "  + String(repo.forks ?? 0)
        langLabel.text = "Language: \(repo.language ?? "nil")"
        lastCommitLabel.text = "Loading..."
    }
    
    func configureCommit(repo: Repo, vm: CommitsViewModel) {
        guard let name = repo.name else {
            return
        }
        vm.getCommits(user: name, completion: { [weak self] result, err in
            DispatchQueue.main.async {
                self?.lastCommitLabel.text = "Last commit: \(result?.first?.sha ?? "commit not found")"
            }
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        repoNameLabel.text = ""
        descriptionLabel.text = ""
        starLabel.text = ""
        forkLabel.text = ""
        langLabel.text = ""
        lastCommitLabel.text = ""
    }
    
}
