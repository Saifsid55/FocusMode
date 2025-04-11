//
//  TimerViewController.swift
//  DailyRounds Assignment
//
//  Created by Mohd Saif on 11/04/25.
//

import UIKit

class TimerViewController: UIViewController {
    private let viewModel = TimerViewModel()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedDigitSystemFont(ofSize: 48, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let badgesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop Focusing", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Focus Timer"
        setupLayout()
        bindViewModel()
        updateTimerLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    private func setupLayout() {
        setupTimeLabel()
        setupBadgesLabel()
        setupStopButton()
    }
    
    
    private func setupTimeLabel() {
        view.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupBadgesLabel() {
        view.addSubview(badgesLabel)
        badgesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            badgesLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 40),
            badgesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            badgesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            
        ])
    }
    
    private func setupStopButton() {
        view.addSubview(stopButton)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.widthAnchor.constraint(equalToConstant: 200),
            stopButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        stopButton.addTarget(self, action: #selector(stopTapped), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.onTimeUpdate = { [weak self] formatted in
            self?.timeLabel.text = formatted
        }
        
        viewModel.onBadgeUpdate = { [weak self] badge in
            self?.updateBadgeLabel()
        }
        
        viewModel.onSessionEnd = { [weak self] session in
            self?.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func updateTimerLabel() {
        timeLabel.text = viewModel.formattedTime()
    }
    
    private func updateBadgeLabel() {
        badgesLabel.text = viewModel.badges.map { $0.emoji }.joined(separator: " ")
    }
    
    @objc private func stopTapped() {
        let alert = UIAlertController(
            title: "End Focus Session?",
            message: "Are you sure you want to stop focusing? Your progress will be saved.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Stop", style: .destructive, handler: { [weak self] _ in
            self?.viewModel.stopSession()
        }))
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        present(alert, animated: true, completion: nil)
    }
}
