//
//  ProfileViewModel.swift
//  DailyRounds Assignment
//
//  Created by Mohd Saif on 11/04/25.
//

import Foundation
import UIKit

final class ProfileViewModel {
    private var user: User
 
    init() {
        self.user = StorageManager.shared.loadUser() ?? User(name: "Mohd Saif", profileImageData: nil, profileImageName: "userProfile", totalPoints: 0, badges: [], sessions: [])
    }
    
    var userName: String {
        return user.name
    }
    
    var profileImage: UIImage? {
        if let data = user.profileImageData {
            return UIImage(data: data)
        } else if let imageName = user.profileImageName {
            return UIImage(named: imageName)
        }
        return nil
    }
    
    var totalPoints: Int {
        return user.totalPoints
    }
    
    var allBadges: [String] {
        return user.badges.map { $0.emoji }
    }

    var recentSessions: [Session] {
        return user.sessions
    }
    
    func deleteSession(at index: Int) {
        user.sessions.remove(at: index)
        StorageManager.shared.saveUser(user)
    }
}
