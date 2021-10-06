//
//  GetStatsSummary.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 05.10.21.
//

import Foundation
import UIKit


protocol GetStatsSummary {
    func getFoodSummaries(_ foods: [Food]? ) -> Summary?
    func getSleepSummaries(_ sleeps: [Sleep]? ) -> Summary?
    func getWeightSummaries(_ weights: [Weight]? ) -> Summary?
    func getMoodSummaries(_ moods: [Mood]? ) -> Summary?
    func getWorkoutSummaries(_ workouts: [Workout]? ) -> Summary?
    //func getMetricsSummaries(_ metrics: [Metric]? ) -> Summary?
}

extension GetStatsSummary {
    
    func getWorkoutSummaries(_ workouts: [Workout]? ) -> Summary? {
        var groupByDay = [Workout]()
        
        if workouts!.isEmpty {
            return nil
        }
        
        for w in workouts! {
            let day = getDayStringFromDate(date: w.time!)
            let duration = Int16(w.durationUnit == "Minutes" ? Float(w.duration) : Float(w.duration * 60))
            w.durationUnit = "Minutes"
            if let dayVal = groupByDay.firstIndex(where: {getDayStringFromDate(date: $0.time!) == day}) {
                groupByDay[dayVal].duration += duration
            } else {
                w.duration = duration
                groupByDay.append(w)
            }
        }
        
 
        // do calculations
        let latestDay = groupByDay.last
        
        var restOfDays = groupByDay[0..<Int(groupByDay.count - 1)]
        if restOfDays.isEmpty {
            restOfDays = groupByDay[0..<Int(groupByDay.count)]
        }
        
        var workoutDuration: Int16 = 0
        for r in restOfDays {
            workoutDuration += r.duration
        }
        
        let avgTime = workoutDuration / Int16(restOfDays.count)
        var up = true
        var diff: Int32 = Int32(avgTime) - Int32(latestDay!.duration)
        if diff > 0 {
            up = false
        } else {
            diff = abs(diff)
        }
        
        let idealWorkoutTime = 40
        
        let percentage = Int(round((Float(diff) / Float(avgTime)) * 100.0))
        let upOrDown =  up ? "up" : "down"
        
        let totalAverageTime = Int((workoutDuration + latestDay!.duration)) / (restOfDays.count + 1)
        
        let iconSlash = UIImage(systemName: "heart.slash.fill")!
        let icon = UIImage(systemName: "heart.fill")!
        
        let workoutOkay = percentage > 0 && up && latestDay!.duration >= idealWorkoutTime
        let latestWorkoutOkay = latestDay!.duration >= idealWorkoutTime
        let avgWorkoutOkay = totalAverageTime >= idealWorkoutTime
        let statusIcon: UIImage = workoutOkay ? icon : iconSlash
        let latestIcon = latestWorkoutOkay ? icon : iconSlash
        let avgIcon = avgWorkoutOkay ? icon : iconSlash
        
        let status = KeyValue(key: "Workout Status", value: "\(percentage)% \(upOrDown)", color: getColor(workoutOkay), icon: statusIcon)
        let latest = KeyValue(key: "Workout (Mins)", value: "\(latestDay!.duration)", color: getColor(latestWorkoutOkay), icon: latestIcon)
        
        let average = KeyValue(key: "Average Min/Day", value: "\(totalAverageTime)", color: getColor(avgWorkoutOkay), icon: avgIcon)
        let days = KeyValue(key: "Days Logged", value: "\(groupByDay.count)", color: UIColor(named: "AppDarkPinkPrio")!)
    
        return Summary(status: status, latest: latest, average: average, days: days)
    }
    
    func getFoodSummaries(_ foods: [Food]? ) -> Summary? {
        var groupByDay = [CaloriesChartEntry]()
        
        if foods!.isEmpty {
            return nil
        }
        
        for f in foods! {
            let day = getDayStringFromDate(date: f.time!)
            if let dayVal = groupByDay.firstIndex(where: {getDayStringFromDate(date: $0.date) == day}) {
                groupByDay[dayVal].calories += Int(f.calories)
            } else {
                let entry = CaloriesChartEntry(date: f.time!, calories: Int(f.calories))
                groupByDay.append(entry)
            }
        }
        
        // do calculations
        let latestDay = groupByDay.last
        
        var restOfDays = groupByDay[0..<Int(groupByDay.count - 1)]
        if restOfDays.isEmpty {
            restOfDays = groupByDay[0..<Int(groupByDay.count)]
        }
        
        var calCount: Int16 = 0
        for r in restOfDays {
            calCount += Int16(r.calories)
        }
        let avgCal = calCount / Int16(restOfDays.count)
        var up = true
        var diff: Int32 = Int32(avgCal) - Int32(latestDay!.calories)
        if diff > 0 {
            up = false
        } else {
            diff = abs(diff)
        }
        
        let idealCalorieCount = 1200
        
        let percentage = Int(round((Float(diff) / Float(avgCal)) * 100.0))
        let upOrDown =  up ? "up" : "down"
        
        let totalAverageCal = (calCount + Int16(latestDay!.calories)) / Int16(restOfDays.count + 1)
        
        let iconSlash = UIImage(systemName: "heart.slash.fill")!
        let icon = UIImage(systemName: "heart.fill")!
        
        let caloriesOkay = percentage < 100 && latestDay!.calories <= idealCalorieCount
        let latestCaloriesOkay = latestDay!.calories <= idealCalorieCount
        let avgCalLess = totalAverageCal <= idealCalorieCount
        let statusIcon: UIImage = caloriesOkay ? icon : iconSlash
        let latestIcon = latestCaloriesOkay ? icon : iconSlash
        let avgIcon = avgCalLess ? icon : iconSlash
        
        let status = KeyValue(key: "Calories Status", value: "\(percentage)% \(upOrDown)", color: getColor(caloriesOkay), icon: statusIcon)
        let latest = KeyValue(key: "Calorie Count", value: "\(latestDay!.calories)", color: getColor(latestCaloriesOkay), icon: latestIcon)
        
        let average = KeyValue(key: "Avg Calories/Day", value: "\(totalAverageCal)", color: getColor(avgCalLess), icon: avgIcon)
        let days = KeyValue(key: "Days Logged", value: "\(groupByDay.count)", color: UIColor(named: "AppDarkPinkPrio")!)
    
        
        return Summary(status: status, latest: latest, average: average, days: days)
    }
    
    func getSleepSummaries(_ sleeps: [Sleep]? ) -> Summary? {
        var groupByDay = [SleepChartEntry]()
        
        if sleeps!.isEmpty {
            return nil
        }
        
        for s in sleeps! {
            let day = getDayStringFromDate(date: s.time!)
            let duration = s.durationUnit == TimeUnits.hours ? Float(s.duration) : Float(s.duration / 60)
            if let dayVal = groupByDay.firstIndex(where: {getDayStringFromDate(date: $0.date) == day}) {
                groupByDay[dayVal].hours += duration
            } else {
                let entry = SleepChartEntry(date: s.time!, hours: duration)
                groupByDay.append(entry)
            }
        }
        
        // do calculations
        let latestDay = groupByDay.last
        
        var restOfDays = groupByDay[0..<Int(groupByDay.count - 1)]
        if restOfDays.isEmpty {
            restOfDays = groupByDay[0..<Int(groupByDay.count)]
        }
        
        var sleepTime: Float = 0
        for r in restOfDays {
            sleepTime += r.hours
        }
        let avgTime = sleepTime / Float(restOfDays.count)
        var up = true
        var diff: Int32 = Int32(avgTime) - Int32(latestDay!.hours)
        if diff > 0 {
            up = false
        } else {
            diff = abs(diff)
        }
        
        let idealSleepTime: Float = 8.0
        
        let percentage = Int(round((Float(diff) / Float(avgTime)) * 100.0))
        let upOrDown =  up ? "up" : "down"
        
        let iconSlash = UIImage(systemName: "heart.slash.fill")!
        let icon = UIImage(systemName: "heart.fill")!
        
        let sleepOkay = percentage > 0 && up && latestDay!.hours >= idealSleepTime
        let latestSleepOkay = latestDay!.hours >= idealSleepTime
        let avgSleepOkay = avgTime >= idealSleepTime
        let statusIcon: UIImage = sleepOkay ? icon : iconSlash
        let latestIcon = latestSleepOkay ? icon : iconSlash
        let avgIcon = avgSleepOkay ? icon : iconSlash
        
        let status = KeyValue(key: "Sleep Time", value: "\(percentage)% \(upOrDown)", color: getColor(sleepOkay), icon: statusIcon)
        let latest = KeyValue(key: "Sleep Time (Hrs)", value: "\(Int(latestDay!.hours))", color: getColor(latestSleepOkay), icon: latestIcon)
        
        let average = KeyValue(key: "Average Hrs/Day", value: "\(Int(avgTime))", color: getColor(avgSleepOkay), icon: avgIcon)
        let days = KeyValue(key: "Days Logged", value: "\(groupByDay.count)", color: UIColor(named: "AppDarkPinkPrio")!)
    
        return Summary(status: status, latest: latest, average: average, days: days)
    }
    
    func getWeightSummaries(_ weights: [Weight]? ) -> Summary? {
        if weights!.isEmpty {
            return nil
        }
        
        // do calculations
        let latestDay = weights!.last
        
        var restOfDays =  weights![0..<Int(weights!.count - 1)]
        if restOfDays.isEmpty {
            restOfDays = weights![0..<Int(weights!.count)]
        }
        
        var totalWeight: Float = 0.0
        for r in restOfDays {
            let kg = r.unit == WeightUnits.kg ? Float(r.weight) : Float(r.weight / 2.2)
            totalWeight += kg
        }
        
        let avgWeight = totalWeight / Float(restOfDays.count)
        let latestWeight = latestDay!.unit == WeightUnits.kg ? Float(latestDay!.weight) : Float(latestDay!.weight / 2.2)
        
        var up = true
        var diff: Int32 = Int32(avgWeight) - Int32(latestWeight)
        if diff > 0 {
            up = false
        } else {
            diff = abs(diff)
        }
        
        let idealWeight: Float = 70.0
        
        let percentage = Int(round((Float(diff) / Float(avgWeight)) * 100.0))
        let upOrDown =  up ? "up" : "down"
        
        let iconSlash = UIImage(systemName: "heart.slash.fill")!
        let icon = UIImage(systemName: "heart.fill")!
        let latestWeightInKg = latestDay!.unit == WeightUnits.kg ? Float(latestDay!.weight) : Float(latestDay!.weight / 2.2)
        
        let totalAverageWeight = (totalWeight + latestWeightInKg) / Float(restOfDays.count + 1)
        
        let weightOkay = (up == false) && percentage > 0
        let latestWeightOkay = latestDay!.weight <= idealWeight
        let avgWeightOkay = totalAverageWeight <= idealWeight
        let statusIcon: UIImage = weightOkay ? icon : iconSlash
        let latestIcon = latestWeightOkay ? icon : iconSlash
        let avgIcon = avgWeightOkay ? icon : iconSlash
        
        let weight = latestDay!.unit == WeightUnits.kg ? Float(latestDay!.weight) : Float(latestDay!.weight / 2.2)
        
        let status = KeyValue(key: "Weight Status", value: "\(percentage)% \(upOrDown)", color: getColor(weightOkay), icon: statusIcon)
        let latest = KeyValue(key: "Weight (kg)", value: "\(toDecPlacesString(value: weight, num: 2))", color: getColor(latestWeightOkay), icon: latestIcon)
        
        let average = KeyValue(key: "Average Weight", value: "\(toDecPlacesString(value: totalAverageWeight, num: 2))", color: getColor(avgWeightOkay), icon: avgIcon)
        
        let days = KeyValue(key: "Times Logged", value: "\(weights!.count)", color: UIColor(named: "AppDarkPinkPrio")!)
    
        return Summary(status: status, latest: latest, average: average, days: days)
    }
    
    func getMoodSummaries(_ moods: [Mood]? ) -> Summary? {
        if moods!.isEmpty {
            return nil
        }
        
        let latestDay = moods!.last
        
        var restOfDays =  moods![0..<Int(moods!.count - 1)]
        if restOfDays.isEmpty {
            restOfDays = moods![0..<Int(moods!.count)]
        }
        
        var moodTotal: Int = 0
        for r in restOfDays {
            moodTotal += Moods.getMoodValue(r.mood!)
        }
        
        let avgMood = moodTotal / restOfDays.count
       
        var up = true
        var diff: Int32 = Int32(avgMood) - Int32(Moods.getMoodValue(latestDay!.mood!))
        if diff > 0 {
            up = false
        } else {
            diff = abs(diff)
        }
        
        let idealMood = 4
        
        let percentage = Int(round((Float(diff) / Float(avgMood) * 100.0)))
        let upOrDown =  up ? "up" : "down"
        
        let totalAverageMood = ( moodTotal + Moods.getMoodValue(latestDay!.mood!)) / Int(restOfDays.count + 1)
        
        let iconSlash = UIImage(systemName: "heart.slash.fill")!
        let icon = UIImage(systemName: "heart.fill")!
        
        let moodOkay = percentage >= 0 && up
        let latestMoodOkay = Moods.getMoodValue(latestDay!.mood!) >= idealMood
        let avgMoodOkay = Int(totalAverageMood) >= idealMood
        let statusIcon: UIImage = moodOkay ? icon : iconSlash
        let latestIcon = latestMoodOkay ? icon : iconSlash
        let avgIcon = avgMoodOkay ? icon : iconSlash
        
        let status = KeyValue(key: "Mood Status", value: "\(percentage)% \(upOrDown)", color: getColor(moodOkay), icon: statusIcon)
        let latest = KeyValue(key: "Mood", value: "\(latestDay!.mood!)", color: getColor(latestMoodOkay), icon: latestIcon)
        
        let average = KeyValue(key: "Average Mood", value: "\(Moods.getMoodForValue(Int(totalAverageMood)))", color: getColor(avgMoodOkay), icon: avgIcon)
                                   
        let days = KeyValue(key: "Times Logged", value: "\(moods!.count)", color: UIColor(named: "AppDarkPinkPrio")!)
    
        return Summary(status: status, latest: latest, average: average, days: days)
    }
    
    func getColor(_ isTrue: Bool) -> UIColor {
        return isTrue ? .green : .red
    }
    
    func getDayStringFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        return formatter.string(from: date)
    }
    
    func toDecPlacesString(value: Float, num: Int) -> String {
        return String(format: "%.\(num)f", value)
    }
    
}
