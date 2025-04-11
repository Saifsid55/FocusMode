//
//  HomeViewModel.swift
//  DailyRounds Assignment
//
//  Created by Mohd Saif on 11/04/25.
//
import Foundation

final class HomeViewModel {
    let focusModes = ["Work", "Play", "Rest", "Sleep"]

    func startMode(_ mode: String) {
        SessionManager.shared.startSession(mode: mode)
        StorageManager.shared.saveOngoingSession(SessionManager.shared.currentSession!, startTime: Date())
    }
}
