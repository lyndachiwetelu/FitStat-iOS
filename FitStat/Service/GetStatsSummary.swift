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
        
        let iconSlash = UIImage(systemName: "heart.slash.fill")!
        let icon = UIImage(systemName: "heart.fill")!
        
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
        
        let iconSlash = UIImage(systemName: "heart.slash.fill")!
        let icon = UIImage(systemName: "heart.fill")!
        
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
        if weights == nil {
            return nil
        }
        
        // do calculations
        let latestDay = weights!.last
        
        let restOfDays = weights!.dropLast()
        
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
        
        let weightOkay = (up == false) && percentage > 0
        let latestWeightOkay = latestDay!.weight <= idealWeight
        let avgWeightOkay = avgWeight <= idealWeight
        let statusIcon: UIImage = weightOkay ? icon : iconSlash
        let latestIcon = latestWeightOkay ? icon : iconSlash
        let avgIcon = avgWeightOkay ? icon : iconSlash
        
        let weight = latestDay!.unit == WeightUnits.kg ? Float(latestDay!.weight) : Float(latestDay!.weight / 2.2)
        
        let status = KeyValue(key: "Weight Status", value: "\(percentage)% \(upOrDown)", color: getColor(weightOkay), icon: statusIcon)
        let latest = KeyValue(key: "Weight (kg)", value: "\(round(weight))", color: getColor(latestWeightOkay), icon: latestIcon)
        
        let average = KeyValue(key: "Average Weight", value: "\(round(avgWeight))", color: getColor(avgWeightOkay), icon: avgIcon)
        let days = KeyValue(key: "Times Logged", value: "\(weights!.count)", color: UIColor(named: "AppDarkPinkPrio")!)
    
        return Summary(status: status, latest: latest, average: average, days: days)
    }
    
    func getMoodSummaries(_ moods: [Mood]? ) -> Summary? {
        if moods == nil {
            return nil
        }
        
        let latestDay = moods!.last
        
        let restOfDays = moods!.dropLast()
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
        
        let iconSlash = UIImage(systemName: "heart.slash.fill")!
        let icon = UIImage(systemName: "heart.fill")!
        
        let moodOkay = percentage >= 0 && up
        let latestMoodOkay = Moods.getMoodValue(latestDay!.mood!) >= idealMood
        let avgMoodOkay = Int(avgMood) >= idealMood
        let statusIcon: UIImage = moodOkay ? icon : iconSlash
        let latestIcon = latestMoodOkay ? icon : iconSlash
        let avgIcon = avgMoodOkay ? icon : iconSlash
        
        let status = KeyValue(key: "Mood Status", value: "\(percentage)% \(upOrDown)", color: getColor(moodOkay), icon: statusIcon)
        let latest = KeyValue(key: "Mood", value: "\(latestDay!.mood!)", color: getColor(latestMoodOkay), icon: latestIcon)
        
        let average = KeyValue(key: "Average Mood", value: "\(Moods.getMoodForValue(Int(avgMood)))", color: getColor(avgMoodOkay), icon: avgIcon)
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
    
    
}
