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
    
    var delegate : ChartViewDelegate?
    
    var yAxisText: String = ""
    var xAxisText = ""
    
    
    var lineChartDataSets: [LineChartDataSet]? {
        didSet {
            let lineChartData = LineChartData(dataSets: lineChartDataSets!)
            let chart = LineChartView()
            chart.delegate = delegate
            
            chart.data = lineChartData
            let formatter = XAxisNameFormater()
            chart.xAxis.drawGridLinesEnabled = false
            chart.leftAxis.drawGridLinesEnabled = false
            chart.xAxis.valueFormatter = formatter
            chart.xAxis.labelPosition = .bottom
            chart.leftAxis.labelPosition = .outsideChart
            chart.rightAxis.enabled = false
            chart.legend.enabled = true
            chart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInSine)
            chart.highlightPerTapEnabled = true
            chart.pinchZoomEnabled = true
            chart.doubleTapToZoomEnabled = true
    
            chart.frame = chartView.bounds
            chartView.translatesAutoresizingMaskIntoConstraints = false
           
            chartView.addSubview(chart)
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
            addSubview(contentView)
        }

}
