//
//  ViewController.swift
//  DailyRounds Assignment
//
//  Created by Mohd Saif on 11/04/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    private var stackView: UIStackView!
    private var profileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Focus Modes"
        setupUI()
    }
    
    private func setupUI() {
        setupStackView()
        setupProfileButton()
    }
    
    private func setupStackView() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        setupStackViewData()
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    private func setupProfileButton() {
        profileButton = UIButton(type: .system)
        profileButton.setTitle("Go to Profile", for: .normal)
        profileButton.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
        stackView.addArrangedSubview(profileButton)
    }
    
    private func setupStackViewData() {
        viewModel.focusModes.forEach { mode in
            let button = UIButton(type: .system)
            button.setTitle(mode, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 18)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.addTarget(self, action: #selector(focusModeTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc private func focusModeTapped(_ sender: UIButton) {
        guard let mode = sender.titleLabel?.text else { return }
        viewModel.startMode(mode)
        let timerVC = TimerViewController()
        navigationController?.pushViewController(timerVC, animated: true)
    }
    
    @objc private func openProfile() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

