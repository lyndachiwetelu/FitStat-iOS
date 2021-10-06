//
//  App.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 01.10.21.
//

import Foundation
import UIKit
import Charts

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

struct KeyValue {
    let key: String
    let value: String
    let color: UIColor
    var icon: UIImage? = nil
}

struct Summary {
    let status: KeyValue
    let latest: KeyValue
    let average: KeyValue
    let days : KeyValue
}

struct WeightUnits {
    static let kg = "Kilograms"
    static let lbs = "Pounds"
}

struct TimeUnits {
    static let hours = "Hours"
    static let minutes = "Minutes"
}

struct Metrics {
    static let chest = "Chest"
    static let bust = "Bust"
    static let leftArm = "Left Arm"
    static let rightArm = "Right Arm"
    static let leftThigh = "Left thigh"
    static let rightThigh = "Right Thigh"
    static let waist = "Waist"
    static let belly = "Belly"
}

struct MetricUnits {
    static let metres = "metres"
    static let centimeters = "centimeters"
    static let inches = "inches"
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
    
    static func getMoodForValue(_ value: Int) -> String {
        switch value {
        case 5:
            return joyful
        case 4:
            return happy
        case 3:
            return content
        case 2:
            return indifferent
        case 1:
            return sad
        case 0:
            return depressed
        default:
            return content
        }
    }
}

struct CaloriesChartEntry {
    var date: Date
    var calories: Int
}

struct WorkoutChartEntry {
    var date: Date
    var calories: Int
    var duration: Float
}

struct SleepChartEntry {
    var date: Date
    var hours: Float
}

struct MoodChartEntry {
    var date: Date
    var moodValue: Float
}

struct MetricChartEntry {
    var date: Date
    var centimeters: Float
    var part: String
}

struct MetricChartData {
    let chartData: [ChartDataEntry]
    let color: UIColor
    let label: String
}
