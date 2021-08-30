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
    
    var units = [
        "metres",
        "centimeters",
        "inches",
    ]
    
    var parts = [
        "Chest",
        "Bust",
        "Left Arm",
        "Right Arm",
        "Left thigh",
        "Right Thigh",
        "Waist",
        "Belly"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partOfBodyPicker.delegate = self
        partOfBodyPicker.dataSource = self
        unitPicker.delegate = self
        unitPicker.dataSource = self
    }
    
    @IBAction func logMetricPressed(_ sender: UIButton) {
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
