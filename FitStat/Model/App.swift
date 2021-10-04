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

struct WeightUnits {
    static let kg = "Kilograms"
    static let lbs = "Pounds"
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

struct Moods {
    static let joyful = "Joyful"
    static let indifferent = "Indifferent"
    static let sad = "Sad"
    static let happy = "Happy"
    static let content = "Content"
    static let depressed = "Depressed"
    static let none = "None"
    
    static func getMoodValue(_ mood: String) -> Int {
        switch mood {
        case joyful:
            return 5
        case happy:
            return 4
        case content:
            return 3
        case indifferent:
            return 2
        case sad:
            return 1
        case depressed:
            return 0
        default:
            return 3
        }
    }
}

struct FoodChartEntry {
    var date: Date
    var calories: Int
}

struct SleepChartEntry {
    var date: Date
    var hours: Float
}

struct MoodChartEntry {
    var date: Date
    var moodValue: Float
}
