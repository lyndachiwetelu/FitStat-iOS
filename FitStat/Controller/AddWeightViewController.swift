//
//  AddWeightViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit

class AddWeightViewController: UIViewController {

    @IBOutlet var weightUnitPicker: UIPickerView!
    @IBOutlet var heightUnitPicker: UIPickerView!
    
    var weightUnits = [
        "Kilograms",
        "Pounds"
    ]
    
    var heightUnits = [
        "metres",
        "centimeters",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weightUnitPicker.delegate = self
        weightUnitPicker.dataSource = self
        heightUnitPicker.delegate = self
        heightUnitPicker.dataSource = self
    }
    
    @IBAction func logWeightPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}

extension AddWeightViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 100:
            return weightUnits.count
        default:
            return heightUnits.count
        }
    }
    
    
}

extension AddWeightViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 100:
            return weightUnits[row]
        default:
            return heightUnits[row]
        }
        
    }
}

