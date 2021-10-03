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

struct FoodChartEntry {
    var date: Date
    var calories: Int
}
