//
//  XAxisFormatter.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 03.10.21.
//

import Foundation
import Charts

final class XAxisNameFormater: NSObject, IAxisValueFormatter {
    func stringForValue( _ value: Double, axis _: AxisBase?) -> String {
        // value is a timestamp

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"

        return formatter.string(from: Date(timeIntervalSince1970: value))
    }

}
