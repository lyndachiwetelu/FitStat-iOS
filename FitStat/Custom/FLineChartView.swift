//
//  LineChartView.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 03.10.21.
//

import UIKit
import Charts

class FLineChartView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var yAxisLabel: UILabel!
    @IBOutlet var xAxisLabel: UILabel!
    @IBOutlet var chartView: UIView!
    
    var yAxisText: String = ""
    var xAxisText = ""
    
    
    var lineChartDataSets: [LineChartDataSet]? {
        didSet {
            let lineChartData = LineChartData(dataSets: lineChartDataSets!)
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
            chart.frame = chartView.bounds
            chartView.translatesAutoresizingMaskIntoConstraints = false
            chartView.addSubview(chart)
//            yAxisLabel.frame = CGRect(x: 0.0, y: 0.0, width: 100, height: 50)
            yAxisLabel.transform =  CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
            yAxisLabel.text = yAxisText
            xAxisLabel.text = xAxisText
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
            initSubviews()
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            initSubviews()
        }

        func initSubviews() {
            let nib = UINib(nibName: "FLineChartView", bundle: nil)
            nib.instantiate(withOwner: self, options: nil)
            contentView.frame = bounds
            contentView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(contentView)
        }

}


