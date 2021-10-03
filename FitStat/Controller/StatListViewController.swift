//
//  StatListViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit
import Charts


class StatListViewController: UIViewController {
    var manager = CoreDataManager()

    @IBOutlet var tableView: UITableView!
    
    var cellReuseIdentifier : String {
        "StatListTableViewCell"
    }
    
    let categories =  [
        ["Food Stats", #imageLiteral(resourceName: "chart1"), ],
        ["Sleep Stats", #imageLiteral(resourceName: "chart2"),],
        ["Weight Stats", #imageLiteral(resourceName: "chart1"),],
        ["Workout Stats", #imageLiteral(resourceName: "chart2"), ],
        ["Mood Stats", #imageLiteral(resourceName: "chart1"),],
        ["Body Metrics Stats",#imageLiteral(resourceName: "chart2"),],
    ]
    
    var selectedText = ""
    
    var nextSegue: String {
        "goToShowStats"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "StatListTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
}


extension StatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedText = categories[indexPath.row][0] as! String
        performSegue(withIdentifier: nextSegue, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == nextSegue {
            let destination = segue.destination as! ShowStatsViewController
            destination.navigationItem.title = selectedText
            destination.statsText = selectedText
            destination.lineChartDataSets = getLineChartDataSetsForSelected()
            
        }
       
    }
    
    func getLineChartDataSetsForSelected() -> [LineChartDataSet] {
        switch selectedText {
        case "Food Stats":
            return [getLineChartDataSet(entries: fetchFoodsChartData(), label: "Food")!]
        case "Sleep Stats":
            let sleepSets = fetchSleepsChartData()
            var result = [LineChartDataSet]()
            let labels = ["Light Sleep", "Heavy Sleep"]
            let colors = [UIColor.systemOrange, UIColor.systemPurple]
            for (index, s) in sleepSets.enumerated() {
                let ds = getLineChartDataSet(entries: s, label: labels[index], color: colors[index], textColor: .systemYellow, gradientColor: colors[index].cgColor)!
                result.append(ds)
            }
            return result
        default:
            return [getLineChartDataSet(entries: fetchFoodsChartData(), label: "Food")!]
        }
    }
    
    func getLineChartDataSet(entries: [ChartDataEntry], label: String, color: UIColor = .blue, textColor: UIColor = .systemPink, gradientColor: CGColor = UIColor.systemPink.cgColor) -> LineChartDataSet? {
        let lineChartDataSet = LineChartDataSet(entries: entries, label: label);
        lineChartDataSet.setColor(color)
        lineChartDataSet.valueTextColor = textColor
        let gradientColors = [gradientColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else {
            return nil
        }
        lineChartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 80.0)
        lineChartDataSet.drawFilledEnabled = true
        return lineChartDataSet
    }
}


extension StatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! StatListTableViewCell
        cell.statLabel?.text = categories[indexPath.row][0] as? String
        cell.statChartImage?.image = categories[indexPath.row][1] as? UIImage
        return cell
    }
    
}




//MARK: - CoreDataManager Stuff
extension StatListViewController {
    func fetchFoodsChartData() -> [ChartDataEntry] {
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
    
    func fetchSleepsChartData() -> [[ChartDataEntry]] {
        let sleeps = manager.fetchSleeps()
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
