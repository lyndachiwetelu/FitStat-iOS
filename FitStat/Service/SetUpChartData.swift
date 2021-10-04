//
//  SetUpChartData.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 04.10.21.
//

import Foundation
import Charts


protocol SetUpChartData {
    func fetchFoodsChartData(_ foods: [Food]? ) -> [ChartDataEntry]
    func fetchSleepsChartData(_ sleeps: [Sleep]? ) -> [[ChartDataEntry]]
    func fetchMoodsChartData(_ moods: [Mood]? ) -> [ChartDataEntry]
    func fetchWeightsChartData(_ weights: [Weight]? ) -> [ChartDataEntry]
}


extension SetUpChartData {
    func fetchWeightsChartData(_ weights: [Weight]? = [Weight]() ) -> [ChartDataEntry] {
        var entries = [ChartDataEntry]()

        for w in weights! {
            let kg = w.unit == WeightUnits.kg ? Float(w.weight) : Float(w.weight / 2.2)
            let entry = ChartDataEntry(x: Double(w.time!.timeIntervalSince1970), y: Double(kg))
            entries.append(entry)
        }
        
        return entries
    }
    
    func fetchMoodsChartData(_ moods: [Mood]? = [Mood]() ) -> [ChartDataEntry] {
        var groupByDay = [MoodChartEntry]()
        var entries = [ChartDataEntry]()
        
        for m in moods! {
            let day = getDayStringFromDate(date: m.time!)
            if var dayVal = groupByDay.first(where: {getDayStringFromDate(date: $0.date) == day}) {
                dayVal.moodValue += Float(Moods.getMoodValue(m.mood!))
            } else {
                let moodChartEntry = MoodChartEntry(date: m.time!, moodValue: Float(Moods.getMoodValue(m.mood!)))
                groupByDay.append(moodChartEntry)
            }
        }
        
        for val in groupByDay {
            let entry = ChartDataEntry(x: Double(val.date.timeIntervalSince1970), y: Double(val.moodValue))
            entries.append(entry)
        }
        
        return entries
    }
    
    func fetchFoodsChartData(_ foods: [Food]? = [Food]() ) -> [ChartDataEntry] {
        var groupByDay = [FoodChartEntry]()
        var entries = [ChartDataEntry]()
        
        for f in foods! {
            let day = getDayStringFromDate(date: f.time!)
            if var dayVal = groupByDay.first(where: {getDayStringFromDate(date: $0.date) == day}) {
                dayVal.calories += Int(f.calories)
            } else {
                let foodChartEntry = FoodChartEntry(date: f.time!, calories: Int(f.calories))
                groupByDay.append(foodChartEntry)
            }
        }
        
        for val in groupByDay {
            let entry = ChartDataEntry(x: Double(val.date.timeIntervalSince1970), y: Double(val.calories))
            entries.append(entry)
        }
        
        return entries
    }
    
    func fetchSleepsChartData(_ sleeps: [Sleep]? = [Sleep]()) -> [[ChartDataEntry]] {
        var light = [SleepChartEntry]()
        var heavy = [SleepChartEntry]()
        var lightEntries = [ChartDataEntry]()
        var heavyEntries = [ChartDataEntry]()
        
        for s in sleeps! {
            let day = getDayStringFromDate(date: s.time!)
            let duration = s.durationUnit == "Hours" ? Float(s.duration) : Float(s.duration / 60)
            if s.light {
                if var dayVal = light.first(where: {getDayStringFromDate(date: $0.date) == day}) {
                    dayVal.hours += duration
                } else {
                    let sleepChartEntry = SleepChartEntry(date: s.time!, hours: duration)
                    light.append(sleepChartEntry)
                }
                
            } else {
                if var dayVal = heavy.first(where: {getDayStringFromDate(date: $0.date) == day}) {
                    dayVal.hours += duration
                } else {
                    let sleepChartEntry = SleepChartEntry(date: s.time!, hours: duration)
                    heavy.append(sleepChartEntry)
                }
                
            }
            
        }
        
        for val in light {
            let entry = ChartDataEntry(x: Double(val.date.timeIntervalSince1970), y: Double(val.hours))
            lightEntries.append(entry)
        }
        
        for val in heavy {
            let entry = ChartDataEntry(x: Double(val.date.timeIntervalSince1970), y: Double(val.hours))
            heavyEntries.append(entry)
        }
        
        return [lightEntries, heavyEntries]
    }
    
    func getDayStringFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        return formatter.string(from: date)
    }
    
}
