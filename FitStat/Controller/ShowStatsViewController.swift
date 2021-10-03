//
//  ShowStatsViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 27.08.21.
//

import UIKit
import Charts


class ShowStatsViewController: UIViewController {    
    

    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var statsViewer: UIView!
    var statsText = ""
    var lineChartDataSets = [LineChartDataSet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let chart = FLineChartView()
        chart.lineChartDataSets = lineChartDataSets
        statsViewer.addSubview(chart)
        headingLabel.text = "Your \(statsText) at a glance"
    }
    
    

}
