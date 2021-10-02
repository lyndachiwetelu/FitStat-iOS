//
//  AddWeightViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit

class AddWeightViewController: UIViewController {

    @IBOutlet var weightUnitPicker: UIPickerView!
    @IBOutlet var timePicker: UIDatePicker!
    @IBOutlet var weightTextField: UITextField!
    
    var weightUnits = [
        "Kilograms",
        "Pounds"
    ]
    
    var selectedUnit = "Kilograms"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weightUnitPicker.delegate = self
        weightUnitPicker.dataSource = self
    }
    
    @IBAction func logWeightPressed(_ sender: UIButton) {
        var manager = CoreDataManager.shared
        let weight = manager.getInsertObjectFor(entityNamed: "Weight") as! Weight
        weight.time = timePicker.date
        weight.weight = Float(weightTextField.text ?? "0.0")!
        weight.unit = selectedUnit
        manager.saveContext()
        
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedUnit = weightUnits[row]
    }
}

