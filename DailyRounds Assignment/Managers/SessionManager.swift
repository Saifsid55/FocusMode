//
//  SessionManager.swift
//  DailyRounds Assignment
//
//  Created by Mohd Saif on 11/04/25.
//

import Foundation

final class SessionManager {
    static let shared = SessionManager()
    
    private var timer: Timer?
    private var elapsedTime: TimeInterval = 0
    private var lastBadgeTime: TimeInterval = 0
    private var startTime: Date?

    private(set) var currentSession: Session?
    private(set) var isRunning = false
    private var badgesEarned: [Badge] = []
    
    private init() {}
    
    func startSession(mode: String) {
        let session = Session(
            id: UUID(),
            mode: mode,
            startTime: Date(),
            endTime: nil,
            points: 0,
            badges: []
        )
        startTime = Date()
        currentSession = session
        elapsedTime = 0
        lastBadgeTime = 0
        badgesEarned = []
        isRunning = true
        startTimer()
    }
    
    func stopSession() -> Session? {
        timer?.invalidate()
        timer = nil
        isRunning = false
        
        guard var session = currentSession else { return nil }
        session.endTime = Date()
        session.badges = badgesEarned
        session.points = badgesEarned.count
        
        currentSession = nil
        return session
    }
    
    func resumeSession(session: Session, elapsed: TimeInterval) {
        currentSession = session
        elapsedTime = elapsed
        startTime = Date().addingTimeInterval(-elapsed)
        lastBadgeTime = elapsed
        badgesEarned = session.badges
        isRunning = true
        startTimer()
    }
    
    func calculateBadges(for elapsed: TimeInterval) -> [Badge] {
        let badgeCount = Int(elapsed) / 120
        return (0..<badgeCount).map { _ in Badge.randomBadge() }
    }

    func getElapsedTime() -> TimeInterval {
        guard let start = startTime else { return elapsedTime }
        return Date().timeIntervalSince(start)
    }
    
    func getStartTime() -> Date {
        return startTime ?? Date()
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = nil

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.elapsedTime = Date().timeIntervalSince(self.startTime ?? Date())

            // 💡 Calculate how many full 2-min blocks have passed
            let expectedBadgeCount = Int(self.elapsedTime) / 120
            let currentBadgeCount = self.badgesEarned.count
            let newBadgesNeeded = expectedBadgeCount - currentBadgeCount

            // ✅ Award missing badges
            if newBadgesNeeded > 0 {
                for _ in 0..<newBadgesNeeded {
                    let badge = Badge.randomBadge()
                    self.badgesEarned.append(badge)
                    self.currentSession?.badges = self.badgesEarned
                    NotificationCenter.default.post(name: .badgeAwarded, object: badge)
                }
            }

            NotificationCenter.default.post(name: .timerTicked, object: nil)
        }
    }

}

extension Notification.Name {
    static let timerTicked = Notification.Name("timerTicked")
    static let badgeAwarded = Notification.Name("badgeAwarded")
}
