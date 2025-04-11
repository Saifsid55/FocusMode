//
//  TimerViewModel.swift
//  DailyRounds Assignment
//
//  Created by Mohd Saif on 11/04/25.
//

import Foundation

final class TimerViewModel {
    private(set) var badges: [Badge] = []
    var onTimeUpdate: ((String) -> Void)?
    var onBadgeUpdate: ((Badge) -> Void)?
    var onSessionEnd: ((Session) -> Void)?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(timerUpdated), name: .timerTicked, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(badgeAwarded(_:)), name: .badgeAwarded, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func formattedTime() -> String {
        let elapsed = SessionManager.shared.getElapsedTime()
        let hours = Int(elapsed) / 3600
        let minutes = (Int(elapsed) % 3600) / 60
        let seconds = Int(elapsed) % 60
        
        return hours > 0
        ? String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        : String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc private func timerUpdated() {
        onTimeUpdate?(formattedTime())
    }
    
    @objc private func badgeAwarded(_ notification: Notification) {
        if let badge = notification.object as? Badge {
            badges.append(badge)
            onBadgeUpdate?(badge)
        }
    }
    
    func stopSession() {
        guard let finishedSession = SessionManager.shared.stopSession() else { return }
        
        // Save session to user
        var user = StorageManager.shared.loadUser() ?? User(name: "Mohd Saif", profileImageData: nil, profileImageName: "userProfile", totalPoints: 0, badges: [], sessions: [])
        user.name = "Mohd Saif"
        user.profileImageName = "userProfile"
        user.totalPoints += finishedSession.points
        user.badges.append(contentsOf: finishedSession.badges)
        user.sessions.insert(finishedSession, at: 0)
        StorageManager.shared.saveUser(user)
        
        // Clear ongoing session
        StorageManager.shared.clearOngoingSession()
        
        onSessionEnd?(finishedSession)
    }
}
