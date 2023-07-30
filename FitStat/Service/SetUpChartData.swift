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
    func fetchWorkoutsChartData(_ workouts: [Workout]? ) -> [[ChartDataEntry]]
    func fetchMetricsChartData(_ metrics: [Metric]?) -> [MetricChartData]
}


extension SetUpChartData {
    func fetchMetricsChartData(_ metrics: [Metric]? = [Metric]()) -> [MetricChartData] {
        var metricEntries = [MetricChartEntry]()
        
        var chestEntries = [ChartDataEntry]()
        var bustEntries = [ChartDataEntry]()
        var lArmEntries = [ChartDataEntry]()
        var rArmEntries = [ChartDataEntry]()
        var lThighEntries = [ChartDataEntry]()
        var rThighEntries = [ChartDataEntry]()
        var waistEntries = [ChartDataEntry]()
        var bellyEntries = [ChartDataEntry]()
        
        for m in metrics! {
            let val: Float?
            switch m.unit {
                case MetricUnits.centimeters:
                    val = Float(m.value)
                case MetricUnits.metres:
                    val = Float(m.value * 100)
                case MetricUnits.inches:
                    val = Float(m.value * 2.54)
                default:
                    val = Float(m.value)
            }
            let entry = MetricChartEntry(date: m.time!, centimeters: val!, part: m.part!)
            metricEntries.append(entry)
        }
        
        
        for val in metricEntries {
            let entry = ChartDataEntry(x: Double(val.date.timeIntervalSince1970), y: Double(val.centimeters))
            switch val.part {
            case Metrics.chest:
                chestEntries.append(entry)
            case Metrics.bust:
                bustEntries.append(entry)
            case Metrics.leftArm:
                lArmEntries.append(entry)
            case Metrics.rightArm:
                rArmEntries.append(entry)
            case Metrics.leftThigh:
                lThighEntries.append(entry)
            case Metrics.rightThigh:
                rThighEntries.append(entry)
            case Metrics.waist:
                waistEntries.append(entry)
            case Metrics.belly:
                bellyEntries.append(entry)
            default:
                // do nothing?
                chestEntries.append(entry)
            }
            
        }
        
        let labels = ["Chest", "Bust", "Left Arm", "Right Arm", "Left Thigh", "Right Thigh", "Waist", "Belly"]
        let colors = [UIColor.systemRed, UIColor.white, UIColor.blue, UIColor.purple,
                      UIColor.systemPink, UIColor.brown, UIColor.green, UIColor.yellow]
        
        var toReturn = [MetricChartData]()
        for (index, e) in [chestEntries, bustEntries, lArmEntries, rArmEntries, lThighEntries, rThighEntries, waistEntries, bellyEntries].enumerated() {
            if !e.isEmpty {
                let chartData = MetricChartData(chartData: e, color: colors[index], label: labels[index])
                toReturn.append(chartData)
            }
        }
        
        return toReturn
    }
    
    
    func fetchWorkoutsChartData(_ workouts: [Workout]? = [Workout]() ) -> [[ChartDataEntry]] {
        var groupByDay = [WorkoutChartEntry]()
        var entries = [ChartDataEntry]()
        var durationEntries = [ChartDataEntry]()
        
        for w in workouts! {
            let day = getDayStringFromDate(date: w.time!)
            let duration = w.durationUnit == TimeUnits.minutes ? Float(w.duration) : Float(w.duration) * 60.0
            if let dayVal = groupByDay.firstIndex(where: {getDayStringFromDate(date: $0.date) == day}) {
                groupByDay[dayVal].calories += Int(w.calories)
                groupByDay[dayVal].duration += duration
            } else {
                let chartEntry = WorkoutChartEntry(date: w.time!, calories: Int(w.calories), duration: duration)
                groupByDay.append(chartEntry)
            }
        }
        
        for val in groupByDay {
            let entry = ChartDataEntry(x: Double(val.date.timeIntervalSince1970), y: Double(val.calories))
            entries.append(entry)
            let durationEntry = ChartDataEntry(x: Double(val.date.timeIntervalSince1970), y: Double(val.duration))
            durationEntries.append(durationEntry)
        }
        
        return [entries, durationEntries]
    }
    
    func fetchWeightsChartData(_ weights: [Weight]? = [Weight]() ) -> [ChartDataEntry] {
        var entries = [ChartDataEntry]()

        for w in weights! {
            let kg = w.unit == WeightUnits.kg ? Float(w.weight) : Float(w.weight / 2.20462)
            let entry = ChartDataEntry(x: Double(w.time!.timeIntervalSince1970), y: Double(kg))
            entries.append(entry)
        }
        
        return entries
    }
    
    func fetchMoodsChartData(_ moods: [Mood]? = [Mood]() ) -> [ChartDataEntry] {
        var entries = [ChartDataEntry]()
        
        for val in moods! {
            let entry = ChartDataEntry(x: Double(val.time!.timeIntervalSince1970), y: Double(Moods.getMoodValue(val.mood!)))
            entries.append(entry)
        }
        
        return entries
    }
    
    func fetchFoodsChartData(_ foods: [Food]? = [Food]() ) -> [ChartDataEntry] {
        var groupByDay = [CaloriesChartEntry]()
        var entries = [ChartDataEntry]()
        
        for f in foods! {
            let day = getDayStringFromDate(date: f.time!)
            if let dayVal = groupByDay.firstIndex(where: {getDayStringFromDate(date: $0.date) == day}) {
                groupByDay[dayVal].calories += Int(f.calories)
            } else {
                let foodChartEntry = CaloriesChartEntry(date: f.time!, calories: Int(f.calories))
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
            let duration = s.durationUnit == TimeUnits.hours ? Float(s.duration) : Float(s.duration / 60)
            if s.light {
                if let dayVal = light.firstIndex(where: {getDayStringFromDate(date: $0.date) == day}) {
                    light[dayVal].hours += duration
                } else {
                    let sleepChartEntry = SleepChartEntry(date: s.time!, hours: duration)
                    light.append(sleepChartEntry)
                }
                
            } else {
                if let dayVal = heavy.firstIndex(where: {getDayStringFromDate(date: $0.date) == day}) {
                    heavy[dayVal].hours += duration
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
