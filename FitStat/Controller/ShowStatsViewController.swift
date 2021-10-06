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
    var summaries: [Summary]? {
        didSet {
            summary = summaries?.first
        }
    }
    var statsText = ""
    var lineChartDataSets = [LineChartDataSet]()
    var bubbleChartDataSets = [BubbleChartDataSet]()
    var yText: String = ""
    var xText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chart = FLineChartView()
        chart.delegate = self
        chart.yAxisText = yText
        chart.xAxisText = xText
        chart.frame = statsViewer.bounds
        chart.lineChartDataSets = lineChartDataSets
        statsViewer.addSubview(chart)
        
        headingLabel.text = "Your \(statsText) at a glance"
        
        if summary == nil && summaries == nil {
            handleEmptySummary()
        }
        loadSummary()
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
    
    func loadSummary() {
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
}


extension ShowStatsViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if !summaries?.isEmpty {
            summary = summaries![highlight.dataSetIndex]
            DispatchQueue.main.async {
                self.loadSummary()
            }
        }
    }

    func chartValueNothingSelected(_ chartView: ChartViewBase)
    {
    }
}
