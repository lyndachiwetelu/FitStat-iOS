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
    }
    
}
