//
//  App.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 01.10.21.
//

import Foundation

struct AppConstant {
    
    //MARK: - Segues
    static let segueToMainView = "GoToMainView"
    static let segueToUserDetailsView = "GoToUserDetails"
    
    static let segueToFoodView = "goToNextViewFood"
    static let segueToSleepView = "goToNextViewSleep"
    static let segueToMoodView = "goToNextViewMood"
    static let segueToWeightView = "goToNextViewWeight"
    static let segueToWorkoutView = "goToNextViewWorkout"
    static let segueToMetricView = "goToNextViewMetric"
    
    //MARK: - Data Keys
    static let userDetailsKey = "userDetails"

}

// stats
struct Stats {
    static let food = "Food Stats"
    static let sleep = "Sleep Stats"
    static let weight = "Weight Stats"
    static let workout = "Workout Stats"
    static let mood = "Mood Stats"
    static let metric = "Body Metrics Stats"
}

struct FoodChartEntry {
    var date: Date
    var calories: Int
}

struct SleepChartEntry {
    var date: Date
    var hours: Float
}
