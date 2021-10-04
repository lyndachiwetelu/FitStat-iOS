//
//  AddBodyMetricViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit

class AddBodyMetricViewController: UIViewController {

    @IBOutlet var partOfBodyPicker: UIPickerView!
    @IBOutlet var unitPicker: UIPickerView!
    @IBOutlet var timePicker: UIDatePicker!
    
    @IBOutlet var valueTextField: UITextField!
    var units = [
        MetricUnits.centimeters,
        MetricUnits.metres,
        MetricUnits.inches
    ]
    
    var selectedUnit = MetricUnits.centimeters
    
    var parts = [
        Metrics.chest,
        Metrics.bust,
        Metrics.leftArm,
        Metrics.rightArm,
        Metrics.leftThigh,
        Metrics.rightThigh,
        Metrics.waist,
        Metrics.belly
    ]
    
    var selectedPart = Metrics.chest
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partOfBodyPicker.delegate = self
        partOfBodyPicker.dataSource = self
        unitPicker.delegate = self
        unitPicker.dataSource = self
    }
    
    @IBAction func logMetricPressed(_ sender: UIButton) {
        var manager = CoreDataManager.shared
        let metric = manager.getInsertObjectFor(entityNamed: "Metric") as! Metric
        metric.time = timePicker.date
        metric.value = Float(valueTextField.text ?? "")!
        metric.unit = selectedUnit
        metric.part = selectedPart
        manager.saveContext()
        navigationController?.popViewController(animated: true)
    }

}


extension AddBodyMetricViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 100:
            return parts[row]
        default:
            return units[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 100:
            selectedPart = parts[row]
        default:
            selectedUnit = units[row]
        }
    }
    
}

extension AddBodyMetricViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 100:
            return parts.count
        default:
            return units.count
        }
    }
    
    
}
