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
}

extension GetStatsSummary {
    func getFoodSummaries(_ foods: [Food]? ) -> Summary? {
        var groupByDay = [Food]()
        
        if  foods == nil {
            return nil
        }
        
        for f in foods! {
            let day = getDayStringFromDate(date: f.time!)
            if let dayVal = groupByDay.firstIndex(where: {getDayStringFromDate(date: $0.time!) == day}) {
                groupByDay[dayVal].calories += Int16(Int(f.calories))
            } else {
                groupByDay.append(f)
            }
        }
        
        // do calculations
        let latestDay = groupByDay.last
        
        let restOfDays = groupByDay.dropLast()
        
        var calCount: Int16 = 0
        for r in restOfDays {
            calCount += r.calories
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
        
        var iconSlash = UIImage(systemName: "heart.slash.fill")!
        var icon = UIImage(systemName: "heart.fill")!
        
        let caloriesOkay = percentage < 100 && latestDay!.calories <= idealCalorieCount
        let latestCaloriesOkay = latestDay!.calories <= idealCalorieCount
        let avgCalLess = avgCal <= idealCalorieCount
        let statusIcon: UIImage = caloriesOkay ? icon : iconSlash
        let latestIcon = latestCaloriesOkay ? icon : iconSlash
        let avgIcon = avgCalLess ? icon : iconSlash
        
        let status = KeyValue(key: "Calories Status", value: "\(percentage)% \(upOrDown)", color: getColor(caloriesOkay), icon: statusIcon)
        let latest = KeyValue(key: "Calorie Count", value: "\(latestDay!.calories)", color: getColor(latestCaloriesOkay), icon: latestIcon)
        
        let average = KeyValue(key: "Avg Calories/Day", value: "\(avgCal)", color: getColor(avgCalLess), icon: avgIcon)
        let days = KeyValue(key: "Days Logged", value: "\(groupByDay.count)", color: UIColor(named: "AppDarkPinkPrio")!)
    
        
        return Summary(status: status, latest: latest, average: average, days: days)
    }
    
    func getSleepSummaries(_ sleeps: [Sleep]? ) -> Summary? {
        var groupByDay = [Sleep]()
        
        if sleeps == nil {
            return nil
        }
        
        for s in sleeps! {
            let newSleep = s
            let day = getDayStringFromDate(date: s.time!)
            let duration = s.durationUnit == "Hours" ? Float(s.duration) : Float(s.duration / 60)
            newSleep.durationUnit = "Hours"
            if let dayVal = groupByDay.firstIndex(where: {getDayStringFromDate(date: $0.time!) == day}) {
                groupByDay[dayVal].duration += Int16(duration)
            } else {
                groupByDay.append(newSleep)
            }
        }
        
        // do calculations
        let latestDay = groupByDay.last
        
        let restOfDays = groupByDay.dropLast()
        
        var sleepTime: Int16 = 0
        for r in restOfDays {
            sleepTime += r.duration
        }
        let avgTime = sleepTime / Int16(restOfDays.count)
        var up = true
        var diff: Int32 = Int32(avgTime) - Int32(latestDay!.duration)
        if diff > 0 {
            up = false
        } else {
            diff = abs(diff)
        }
        
        let idealSleepTime = 8
        
        let percentage = Int(round((Float(diff) / Float(avgTime)) * 100.0))
        let upOrDown =  up ? "up" : "down"
        
        var iconSlash = UIImage(systemName: "heart.slash.fill")!
        var icon = UIImage(systemName: "heart.fill")!
        
        let sleepOkay = percentage > 0 && up && latestDay!.duration >= idealSleepTime
        let latestSleepOkay = latestDay!.duration >= idealSleepTime
        let avgSleepOkay = avgTime >= idealSleepTime
        let statusIcon: UIImage = sleepOkay ? icon : iconSlash
        let latestIcon = latestSleepOkay ? icon : iconSlash
        let avgIcon = avgSleepOkay ? icon : iconSlash
        
        let status = KeyValue(key: "Sleep Time", value: "\(percentage)% \(upOrDown)", color: getColor(sleepOkay), icon: statusIcon)
        let latest = KeyValue(key: "Sleep Time (Hrs)", value: "\(latestDay!.duration)", color: getColor(latestSleepOkay), icon: latestIcon)
        
        let average = KeyValue(key: "Average Hrs/Day", value: "\(avgTime)", color: getColor(avgSleepOkay), icon: avgIcon)
        let days = KeyValue(key: "Days Logged", value: "\(groupByDay.count)", color: UIColor(named: "AppDarkPinkPrio")!)
    
        return Summary(status: status, latest: latest, average: average, days: days)
    }
    
    func getWeightSummaries(_ weights: [Weight]? ) -> Summary? {
        var groupByDay = [Weight]()
        
        if weights == nil {
            return nil
        }
        
        for w in weights! {
            let day = getDayStringFromDate(date: w.time!)
            let kg = w.unit == WeightUnits.kg ? Float(w.weight) : Float(w.weight / 2.2)
            if let dayVal = groupByDay.firstIndex(where: {getDayStringFromDate(date: $0.time!) == day}) {
                groupByDay[dayVal].weight += kg
            } else {
                w.weight = w.unit == WeightUnits.kg ? Float(w.weight) : Float(w.weight / 2.2)
                w.unit = WeightUnits.kg
                groupByDay.append(w)
            }
        }
        
        // do calculations
        let latestDay = groupByDay.last
        
        let restOfDays = groupByDay.dropLast()
        
        var totalWeight: Float = 0.0
        for r in restOfDays {
            totalWeight += r.weight
        }
        let avgWeight = totalWeight / Float(restOfDays.count)
        var up = true
        var diff: Int32 = Int32(avgWeight) - Int32(latestDay!.weight)
        if diff > 0 {
            up = false
        } else {
            diff = abs(diff)
        }
        
        let idealWeight: Float = 70.0
        
        let percentage = Int(round((Float(diff) / Float(avgWeight)) * 100.0))
        let upOrDown =  up ? "up" : "down"
        
        var iconSlash = UIImage(systemName: "heart.slash.fill")!
        var icon = UIImage(systemName: "heart.fill")!
        
        let weightOkay = (up == false) && percentage > 0
        let latestWeightOkay = latestDay!.weight <= idealWeight
        let avgWeightOkay = avgWeight <= idealWeight
        let statusIcon: UIImage = weightOkay ? icon : iconSlash
        let latestIcon = latestWeightOkay ? icon : iconSlash
        let avgIcon = avgWeightOkay ? icon : iconSlash
        
        let weight = latestDay!.unit == WeightUnits.kg ? Float(latestDay!.weight) : Float(latestDay!.weight / 2.2)
        
        let status = KeyValue(key: "Weight Status", value: "\(percentage)% \(upOrDown)", color: getColor(weightOkay), icon: statusIcon)
        let latest = KeyValue(key: "Weight (kg)", value: "\(round(weight))", color: getColor(latestWeightOkay), icon: latestIcon)
        
        let average = KeyValue(key: "Average weight", value: "\(round(avgWeight))", color: getColor(avgWeightOkay), icon: avgIcon)
        let days = KeyValue(key: "Days Logged", value: "\(groupByDay.count)", color: UIColor(named: "AppDarkPinkPrio")!)
    
        return Summary(status: status, latest: latest, average: average, days: days)
    }
    
    func getMoodSummaries(_ moods: [Mood]? ) -> Summary? {
        var groupByDay = [MoodChartEntry]()
        
        if moods == nil {
            return nil
        }
        
        for m in moods! {
            let day = getDayStringFromDate(date: m.time!)
            if let dayVal = groupByDay.firstIndex(where: {getDayStringFromDate(date: $0.date) == day}) {
                groupByDay[dayVal].moodValue += Float(Moods.getMoodValue(m.mood!))
            } else {
                let moodChartEntry = MoodChartEntry(date: m.time!, moodValue: Float(Moods.getMoodValue(m.mood!)))
                groupByDay.append(moodChartEntry)
            }
        }
        
        // do calculations
        let latestDay = groupByDay.last
        
        let restOfDays = groupByDay
        var moodTotal: Float = 0.0
        for r in restOfDays {
            moodTotal += r.moodValue
        }
        
        let avgMood = moodTotal / Float(restOfDays.count)
       
        var up = true
        var diff: Int32 = Int32(avgMood) - Int32(latestDay!.moodValue)
        if diff > 0 {
            up = false
        } else {
            diff = abs(diff)
        }
        
        let idealMood = 4
        
        let percentage = Int(round((Float(diff) / avgMood * 100.0)))
        let upOrDown =  up ? "up" : "down"
        
        var iconSlash = UIImage(systemName: "heart.slash.fill")!
        var icon = UIImage(systemName: "heart.fill")!
        
        let moodOkay = percentage >= 0 && up
        let latestMoodOkay = Int(latestDay!.moodValue) >= idealMood
        let avgMoodOkay = Int(avgMood) >= idealMood
        let statusIcon: UIImage = moodOkay ? icon : iconSlash
        let latestIcon = latestMoodOkay ? icon : iconSlash
        let avgIcon = avgMoodOkay ? icon : iconSlash
        
        let status = KeyValue(key: "Mood Status", value: "\(percentage)% \(upOrDown)", color: getColor(moodOkay), icon: statusIcon)
        let latest = KeyValue(key: "Mood", value: "\( Moods.getMoodForValue(Int(latestDay!.moodValue)) as String )", color: getColor(latestMoodOkay), icon: latestIcon)
        
        let average = KeyValue(key: "Average Mood", value: "\(Moods.getMoodForValue(Int(avgMood)))", color: getColor(avgMoodOkay), icon: avgIcon)
        let days = KeyValue(key: "Days Logged", value: "\(groupByDay.count)", color: UIColor(named: "AppDarkPinkPrio")!)
    
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
    
    
}
