//
//  SessionModel.swift
//  DailyRounds Assignment
//
//  Created by Mohd Saif on 11/04/25.
//
import Foundation

struct Session: Codable {
    let id: UUID
    let mode: String
    var startTime: Date
    var endTime: Date?
    var points: Int
    var badges: [Badge]
    
    var duration: TimeInterval {
        return (endTime ?? Date()).timeIntervalSince(startTime)
    }
}
