//
//  TimerManager.swift
//  SleepMusic
//
//  Created by Jeroen Voogd on 23/04/2023.
//

import Foundation

final class TimerModel: ObservableObject {
    @Published var isActive = false
    @Published var time: String = "0:00"
    @Published var minutes: Float = 5.0 {
        didSet {
            self.time = "\(Int(minutes)):00"
        }
    }
    private var initialTime = 0
    private var endDate = Date()

    // Start the timer with the given amount of minutes
    func start(minutes: Float) {
        self.initialTime = Int(minutes)
        self.endDate = Date()
        self.isActive = true
        self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
    }

    // Show updates of the timer
    func updateCountdown() -> Bool {
        guard isActive else { return false }

        // Gets the current date and makes the time difference calculation
        let now = Date()
        let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970

        // Checks that the countdown is not <= 0
        if diff <= 0 {
            self.isActive = false
            self.time = "0:00"
            return true
        }

        // Turns the time difference calculation into sensible data and formats it
        let date = Date(timeIntervalSince1970: diff)
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)

        // Updates the time string with the formatted time
        self.minutes = Float(minutes)
        self.time = String(format:"%d:%02d", minutes, seconds)
        return false
    }
}
