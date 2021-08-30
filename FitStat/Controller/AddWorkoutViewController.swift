//
//  AddWorkoutViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit

class AddWorkoutViewController: UIViewController {

    @IBOutlet var workoutTimePicker: UIPickerView!
    
    var times = [
        "Hours",
        "Minutes"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutTimePicker.delegate = self
        workoutTimePicker.dataSource = self
    }
    
    @IBAction func logWorkoutPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}

extension AddWorkoutViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return times[row]
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
