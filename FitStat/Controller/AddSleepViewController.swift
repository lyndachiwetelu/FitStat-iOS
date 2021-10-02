//
//  AddSleepViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit
import CoreData

class AddSleepViewController: UIViewController {

    @IBOutlet var durationTextField: UITextField!
    @IBOutlet var lightSleepCheckBox: CheckBoxView!
    @IBOutlet var heavySleepCheckBox: CheckBoxView!
    @IBOutlet var sleepTimePicker: UIPickerView!
    var times = [
        "Hours",
        "Minutes"
    ]
    
    var selectedUnit = "Hours"
    var light: String = "Light"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lightSleepCheckBox.checkBoxLabel.text = "Light Sleep"
        heavySleepCheckBox.checkBoxLabel.text = "Heavy Sleep"
        lightSleepCheckBox.delegate = self
        heavySleepCheckBox.delegate = self
        sleepTimePicker.dataSource = self
        sleepTimePicker.delegate = self

    }
    
    @IBAction func logSleepPressed(_ sender: UIButton) {
        var manager = CoreDataManager.shared
        let context = manager.persistentContainer.viewContext
        let sleep = NSEntityDescription.insertNewObject(forEntityName: "Sleep", into: context) as! Sleep
        sleep.time = Date()
        sleep.duration = Int16(Int(durationTextField.text ?? "")!)
        sleep.durationUnit = selectedUnit
        sleep.light = light == "Light"
        manager.saveContext()
        navigationController?.popViewController(animated: true)
    }
}


extension AddSleepViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
    }
    
    
}

extension AddSleepViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return times[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedUnit =  times[row]
    }
}

extension AddSleepViewController: CheckBoxViewDelegate {
    func checkBoxWasClicked(_ checkbox: CheckBoxView, with value: Bool) {
        if checkbox.checkBoxLabel.text! == "Light Sleep" {
            if value == true {
                light = "Light"
            }
            heavySleepCheckBox.change(to: !value)
        }
        
        if checkbox.checkBoxLabel.text! == "Heavy Sleep" {
            if value == true {
                light = "Heavy"
            }
            lightSleepCheckBox.change(to: !value)
        }
    }
    
}
