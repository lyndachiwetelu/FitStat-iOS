//
//  AddWorkoutViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit

class AddWorkoutViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var workoutTimePicker: UIPickerView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var caloriesTextField: UITextField!
    
    @IBOutlet var durationTextField: UITextField!
    var times = [
        TimeUnits.hours,
        TimeUnits.minutes
    ]
    
    var selectedTime = TimeUnits.hours
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutTimePicker.delegate = self
        workoutTimePicker.dataSource = self
    }
    
    @IBAction func logWorkoutPressed(_ sender: UIButton) {
        var manager = CoreDataManager.shared
        let workout = manager.getInsertObjectFor(entityNamed: "Workout") as! Workout
        workout.time = datePicker.date
        workout.durationUnit = selectedTime
        workout.duration = Int16(Int(durationTextField.text ?? "")!)
        workout.calories = Int16(Int(caloriesTextField.text ?? "")!)
        workout.name = nameTextField.text ?? "Unspecified"
        manager.saveContext()
        
        navigationController?.popViewController(animated: true)
    }

}

extension AddWorkoutViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return times[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTime = times[row]
    }
}

extension AddWorkoutViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
    }
    
    
}
