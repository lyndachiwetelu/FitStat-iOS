//
//  StatListViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit
import Charts


class StatListViewController: UIViewController, SetUpChartData, GetStatsSummary {
    var manager = CoreDataManager()

    @IBOutlet var tableView: UITableView!
    
    var cellReuseIdentifier : String {
        "StatListTableViewCell"
    }
    
    let categories =  [
        [Stats.food, #imageLiteral(resourceName: "chart1"), ],
        [Stats.sleep, #imageLiteral(resourceName: "line-chart1"),],
        [Stats.weight, #imageLiteral(resourceName: "chart"),],
        [Stats.workout, #imageLiteral(resourceName: "line-chart"), ],
        [Stats.mood, #imageLiteral(resourceName: "statistics"),],
        [Stats.metric, #imageLiteral(resourceName: "chart2"),],
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
            setDestinationAxisTexts(destination: destination)
            setDestinationSummaries(destination: destination)
            
        }
       
    }
    
    func setDestinationSummaries(destination: ShowStatsViewController) {
        switch selectedText {
        case Stats.food:
            destination.summary = getFoodSummaries(manager.fetchFoods())
        case Stats.sleep:
            destination.summary = getSleepSummaries(manager.fetchSleeps())
        case Stats.mood:
            destination.summary = getMoodSummaries(manager.fetchMoods())
        case Stats.weight:
            destination.summary = getWeightSummaries(manager.fetchWeights())
        case Stats.workout:
            destination.summary = getWorkoutSummaries(manager.fetchWorkouts())
        case Stats.metric:
            destination.summaries = getMetricsSummaries(manager.fetchMetrics())
        default:
            destination.summary = nil
        }
    }
    
    func setDestinationAxisTexts(destination: ShowStatsViewController) {
        destination.xText = "Days Logged"
        switch selectedText {
        case Stats.food:
            destination.yText = "Calories"
        case Stats.workout:
            destination.yText = "Mins/Calories"
        case Stats.sleep:
            destination.yText = "Hours Slept"
        case Stats.mood:
            destination.yText = "Mood"
        case Stats.weight:
            destination.yText = "Kg"
        case Stats.metric:
            destination.yText = "cm"
            
        default:
            destination.yText = ""
            destination.xText = ""
        }
    }
    
    func getLineChartDataSetsForSelected(_ selected: String? = nil) -> [LineChartDataSet] {
        var text = selectedText
        if selected != nil {
            text = selected!
        }
        
        switch text {
        case Stats.food:
            return [getLineChartDataSet(entries: fetchFoodsChartData(manager.fetchFoods()), label: "Food")!]
        case Stats.sleep:
            let sleepSets = fetchSleepsChartData(manager.fetchSleeps())
            var result = [LineChartDataSet]()
            let labels = ["Light Sleep", "Heavy Sleep"]
            let colors = [UIColor.systemOrange, UIColor.systemPurple]
            for (index, s) in sleepSets.enumerated() {
                let ds = getLineChartDataSet(entries: s, label: labels[index], color: colors[index], textColor: .systemYellow, gradientColor: colors[index].cgColor)!
                result.append(ds)
            }
            return result
        case Stats.mood:
            return [getLineChartDataSet(entries: fetchMoodsChartData(manager.fetchMoods()), label: "Mood", color: UIColor.magenta, textColor: UIColor.white, gradientColor: UIColor.magenta.cgColor)!]
        case Stats.weight:
            return [getLineChartDataSet(entries: fetchWeightsChartData(manager.fetchWeights()), label: "Weight", color: .systemBlue, textColor: UIColor.white, gradientColor: UIColor.blue.cgColor)!]
        case Stats.workout:
            let sets = fetchWorkoutsChartData(manager.fetchWorkouts())
            var result = [LineChartDataSet]()
            let labels = ["Calories Burned", "Duration In Mins"]
            let colors = [UIColor.systemRed, UIColor.white]
            for (index, s) in sets.enumerated() {
                let ds = getLineChartDataSet(entries: s, label: labels[index], color: colors[index], textColor: .systemYellow, gradientColor: colors[index].cgColor)!
                result.append(ds)
            }
            return result
        case Stats.metric:
            let sets = fetchMetricsChartData(manager.fetchMetrics())
            var result = [LineChartDataSet]()
            
            for s in sets {
                let ds = getLineChartDataSet(entries: s.chartData, label: s.label, color: s.color, textColor: .systemYellow, gradientColor: s.color.cgColor, fillGradient: false, fill: false)!
                result.append(ds)
            }
            return result
        default:
            return [LineChartDataSet]()
        }
    }
    
    func getLineChartDataSet(entries: [ChartDataEntry], label: String, color: UIColor = .blue, textColor: UIColor = .systemPink, gradientColor: CGColor = UIColor.systemPink.cgColor, fillGradient : Bool = true, fill : Bool = true) -> LineChartDataSet? {
        let lineChartDataSet = LineChartDataSet(entries: entries, label: label);
        lineChartDataSet.setColor(color)
        lineChartDataSet.valueTextColor = textColor
        let gradientColors = [gradientColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else {
            return nil
        }
        if fillGradient {
            lineChartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 80.0)
        } else  {
            lineChartDataSet.fill = Fill.fillWithCGColor(color.cgColor)
        }
        if fill == false {
            lineChartDataSet.lineWidth = 5.5
        }
        
        lineChartDataSet.highlightEnabled = true
        
        lineChartDataSet.drawFilledEnabled = fill
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


