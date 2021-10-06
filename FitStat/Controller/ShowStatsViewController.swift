//
//  ShowStatsViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 27.08.21.
//

import UIKit
import Charts


class ShowStatsViewController: UIViewController {
    
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var statusValueLabel: UILabel!
    @IBOutlet var latestLabel: UILabel!
    @IBOutlet var latestValueLabel: UILabel!
    
    @IBOutlet var averageLabel: UILabel!
    @IBOutlet var averageValueLabel: UILabel!
    
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var daysLabel: UILabel!
    @IBOutlet var daysValueLabel: UILabel!
    
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var statsViewer: UIView!
    
    @IBOutlet var statusIcon: UIImageView!
    @IBOutlet var latestIcon: UIImageView!
    @IBOutlet var averageIcon: UIImageView!
    
    @IBOutlet var daysIcon: UIImageView!
    
    var summary : Summary?
    var statsText = ""
    var lineChartDataSets = [LineChartDataSet]()
    var bubbleChartDataSets = [BubbleChartDataSet]()
    var yText: String = ""
    var xText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if summary == nil {
            handleEmptySummary()
            return
        }
        
//        let _chart = LineChartView()
//        _chart.data = LineChartData(dataSets: lineChartDataSets)
//        _chart.delegate = self
//        _chart.frame = statsViewer.bounds
//        statsViewer.addSubview(_chart)
//        return
        
        let chart = FLineChartView()
        chart.delegate = self
        chart.yAxisText = yText
        chart.xAxisText = xText
        chart.frame = statsViewer.bounds
        chart.lineChartDataSets = lineChartDataSets
        
        
        headingLabel.text = "Your \(statsText) at a glance"
        statsViewer.addSubview(chart)
        
        statusLabel.text = summary?.status.key
        statusValueLabel.text = summary?.status.value
        statusIcon.image = summary?.status.icon
        statusIcon.tintColor = summary?.status.color
        
        latestLabel.text = summary?.latest.key
        latestValueLabel.text = summary?.latest.value
        latestIcon.image = summary?.latest.icon
        latestIcon.tintColor = summary?.latest.color
        
        averageLabel.text = summary?.average.key
        averageValueLabel.text = summary?.average.value
        averageIcon.image = summary?.average.icon
        averageIcon.tintColor = summary?.average.color
        
        daysLabel.text = summary?.days.key
        daysValueLabel.text = summary?.days.value
    }
    
    func handleEmptySummary() {
        headingLabel.text = "No stats entered yet. Log your \(statsText) to visualize"
        daysIcon.isHidden = true
        statsViewer.isHidden = true
        summaryLabel.isHidden = true
        
        statusLabel.isHidden = true
        statusValueLabel.isHidden = true
        statusIcon.isHidden = true
        
        latestLabel.isHidden = true
        latestValueLabel.isHidden = true
        latestIcon.isHidden = true

        averageLabel.isHidden = true
        averageValueLabel.isHidden = true
        averageIcon.isHidden = true
        
        daysLabel.isHidden = true
        daysValueLabel.isHidden = true
    }
}


//extension ShowStatsViewController: ChartViewDelegate {
//    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//        print(highlight.dataSetIndex)
//    }
//
//    func chartValueNothingSelected(_ chartView: ChartViewBase)
//    {
//        print("nothing selected")
//    }
//}


extension ShowStatsViewController: FLineChartViewDelegate {
    func didTapChartValue() {
        print("was tapped")
    }
    
    
}
