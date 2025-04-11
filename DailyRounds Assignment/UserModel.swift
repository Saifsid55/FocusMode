//
//  UserModel.swift
//  DailyRounds Assignment
//
//  Created by Mohd Saif on 11/04/25.
//
import Foundation

struct User: Codable {
    var name: String
    var profileImageData: Data?
    var profileImageName: String?
    var totalPoints: Int
    var badges: [Badge]
    var sessions: [Session]
}
