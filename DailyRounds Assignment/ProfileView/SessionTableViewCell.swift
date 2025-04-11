//
//  SessionTableViewCell.swift
//  DailyRounds Assignment
//
//  Created by Mohd Saif on 11/04/25.
//

import UIKit

class SessionTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.font = .systemFont(ofSize: 16)
        detailTextLabel?.font = .systemFont(ofSize: 13)
        detailTextLabel?.textColor = .darkGray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with session: Session) {
        let mins = Int(session.duration) / 60
        let secs = Int(session.duration) % 60

        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short

        textLabel?.text = "\(session.mode) | \(mins)m \(secs)s | \(session.points) pts"
        detailTextLabel?.text = "Started: \(formatter.string(from: session.startTime))"
    }
}
