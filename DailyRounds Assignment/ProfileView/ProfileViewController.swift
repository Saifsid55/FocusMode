//
//  ProfileViewController.swift
//  DailyRounds Assignment
//
//  Created by Mohd Saif on 11/04/25.
//
import UIKit

class ProfileViewController: UIViewController {
    private let viewModel = ProfileViewModel()
    
    private var imageView: UIImageView!
    private var nameLabel: UILabel!
    private var pointsLabel: UILabel!
    private var badgesLabel: UILabel!
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Profile"
        setupUI()
        configureData()
    }
    
    private func setupUI() {
        setupImageView()
        setupNameLabel()
        setupPointsLabel()
        setupBadgesLabel()
        setupTableView()
    }
    
    private func setupImageView() {
        imageView = UIImageView()
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 60
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    private func setupNameLabel() {
        nameLabel = UILabel()
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupPointsLabel() {
        pointsLabel = UILabel()
        view.addSubview(pointsLabel)
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pointsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            pointsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        pointsLabel.font = .systemFont(ofSize: 18)
        pointsLabel.textAlignment = .center
    }
    
    private func setupBadgesLabel() {
        badgesLabel = UILabel()
        view.addSubview(badgesLabel)
        badgesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            badgesLabel.topAnchor.constraint(equalTo: pointsLabel.bottomAnchor, constant: 8),
            badgesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            badgesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        badgesLabel.font = .systemFont(ofSize: 24)
        badgesLabel.textAlignment = .center
        badgesLabel.numberOfLines = 0
    }
    
    private func setupTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SessionTableViewCell.self, forCellReuseIdentifier: "SessionTableViewCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: badgesLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureData() {
        imageView.image = viewModel.profileImage ?? UIImage(systemName: "person.circle")
        nameLabel.text = viewModel.userName
        pointsLabel.text = "Total Points: \(viewModel.totalPoints)"
        badgesLabel.text = "Badges: " + viewModel.allBadges.joined(separator: " ")
        tableView.reloadData()
    }
}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recentSessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SessionTableViewCell", for: indexPath) as? SessionTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.recentSessions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteSession(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
