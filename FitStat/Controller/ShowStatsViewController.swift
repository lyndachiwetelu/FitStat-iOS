//
//  ShowStatsViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 27.08.21.
//

import UIKit
import Charts


class ShowStatsViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var statusValueLabel: UILabel!
    @IBOutlet var latestLabel: UILabel!
    @IBOutlet var latestValueLabel: UILabel!
    
    @IBOutlet var averageLabel: UILabel!
    @IBOutlet var averageValueLabel: UILabel!
    
    @IBOutlet var daysLabel: UILabel!
    @IBOutlet var daysValueLabel: UILabel!
    
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var statsViewer: UIView!
    
    @IBOutlet var statusIcon: UIImageView!
    @IBOutlet var latestIcon: UIImageView!
    @IBOutlet var averageIcon: UIImageView!
    
    
    
    
    var summary : Summary?
    var statsText = ""
    var lineChartDataSets = [LineChartDataSet]()
    var bubbleChartDataSets = [BubbleChartDataSet]()
    var yText: String = ""
    var xText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let chart = FLineChartView()
        chart.yAxisText = yText
        chart.xAxisText = xText
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
}
