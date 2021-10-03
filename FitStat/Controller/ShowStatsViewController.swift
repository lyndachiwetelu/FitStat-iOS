//
//  ShowStatsViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 27.08.21.
//

import UIKit
import Charts

class ShowStatsViewController: UIViewController {

    @IBOutlet var statsLabel: UILabel!
    
    var statsText = ""
    
    var manager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataSet = LineChartDataSet(entries: fetchFoods(), label: "Your Food Statistics");
        dataSet.setColor(.blue)
        dataSet.valueTextColor = .systemPink
        let gradientColors = [UIColor.systemPink.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else {
            return
        }
        dataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 80.0)
        dataSet.drawFilledEnabled = true
        
        let lineChartData = LineChartData(dataSet: dataSet)
        let chart = LineChartView()
        chart.data = lineChartData
        let formatter = XAxisNameFormater()
        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.xAxis.valueFormatter = formatter
        chart.xAxis.labelPosition = .bottom
        chart.leftAxis.labelPosition = .outsideChart
        chart.rightAxis.enabled = false
        chart.legend.enabled = true
        chart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInSine)
        chart.frame = CGRect(x: 0, y: 300, width: view.frame.width, height: 300)
        view.addSubview(chart)
        statsLabel.text = ""
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
    
    final class XAxisNameFormater: NSObject, IAxisValueFormatter {
        func stringForValue( _ value: Double, axis _: AxisBase?) -> String {
            // value is a timestamp

            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM"

            return formatter.string(from: Date(timeIntervalSince1970: value))
        }

    }

}
