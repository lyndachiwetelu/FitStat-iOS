//
//  AddWeightViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit

class AddWeightViewController: UIViewController {

    @IBOutlet var weightUnitPicker: UIPickerView!
    
    var weightUnits = [
        "Kilograms",
        "Pounds"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weightUnitPicker.delegate = self
        weightUnitPicker.dataSource = self
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
        return weightUnits.count
    }
    
    
}

extension AddWeightViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weightUnits[row]
    }
}

