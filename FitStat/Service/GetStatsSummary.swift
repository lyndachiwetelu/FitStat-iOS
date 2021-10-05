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
//    func getMoodSummaries(_ moods: [Mood]? ) -> Summary
}

extension GetStatsSummary {
    func getFoodSummaries(_ foods: [Food]? ) -> Summary? {
        var groupByDay = [Food]()
        
        if  foods == nil {
            return nil
        }
        
        for f in foods! {
            let day = getDayStringFromDate(date: f.time!)
            if let dayVal = groupByDay.first(where: {getDayStringFromDate(date: $0.time!) == day}) {
                dayVal.calories += Int16(Int(f.calories))
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
        
        iconSlash = iconSlash.withTintColor(.red)
        icon = icon.withTintColor(.black)
        
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
    
    func getColor(_ isTrue: Bool) -> UIColor {
        return isTrue ? .green : .red
    }
    
    func getDayStringFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        return formatter.string(from: date)
    }
    
    
}
