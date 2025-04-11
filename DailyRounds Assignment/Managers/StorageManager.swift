//
//  StorageManager.swift
//  DailyRounds Assignment
//
//  Created by Mohd Saif on 11/04/25.
//

import Foundation

final class StorageManager {
    static let shared = StorageManager()
    
    private let userKey = "user_data"
    private let sessionKey = "ongoing_session"
    private let sessionStartTimeKey = "session_start_time"
    
    private init() {}
    
    func saveUser(_ user: User) {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: userKey)
        }
    }
    
    func loadUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: userKey),
              let user = try? JSONDecoder().decode(User.self, from: data) else {
            return nil
        }
        return user
    }
    
    func saveOngoingSession(_ session: Session, startTime: Date) {
        if let data = try? JSONEncoder().encode(session) {
            UserDefaults.standard.set(data, forKey: sessionKey)
            UserDefaults.standard.set(startTime, forKey: sessionStartTimeKey)
        }
    }
    
    func getOngoingSession() -> (Session, TimeInterval)? {
        guard let data = UserDefaults.standard.data(forKey: sessionKey),
              let session = try? JSONDecoder().decode(Session.self, from: data),
              let startTime = UserDefaults.standard.object(forKey: sessionStartTimeKey) as? Date else {
            return nil
        }
        
        let elapsed = Date().timeIntervalSince(startTime)
        return (session, elapsed)
    }
    
    func clearOngoingSession() {
        UserDefaults.standard.removeObject(forKey: sessionKey)
        UserDefaults.standard.removeObject(forKey: sessionStartTimeKey)
    }
}
