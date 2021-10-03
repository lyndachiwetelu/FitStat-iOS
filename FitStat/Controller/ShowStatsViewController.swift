//
//  ShowStatsViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 27.08.21.
//

import UIKit
import Charts


class ShowStatsViewController: UIViewController {    
    var statsText = ""
    
    @IBOutlet var statsViewer: UIView!
    var manager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataSet = LineChartDataSet(entries: fetchFoods(), label: "Your Food Statistics");
        let chart = FLineChartView()
        chart.lineChartDataSet = dataSet
        statsViewer.addSubview(chart)
    }
    
    func fetchFoods() -> [ChartDataEntry] {
        let foods = manager.fetchFoods()
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
    
    func getDayStringFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        return formatter.string(from: date)
    }

}
