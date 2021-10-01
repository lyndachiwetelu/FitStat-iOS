//
//  AddSleepViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit

class AddSleepViewController: UIViewController {

    @IBOutlet var lightSleepCheckBox: CheckBoxView!
    @IBOutlet var heavySleepCheckBox: CheckBoxView!
    @IBOutlet var sleepTimePicker: UIPickerView!
    var times = [
        "Hours",
        "Minutes"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lightSleepCheckBox.checkBoxLabel.text = "Light Sleep"
        heavySleepCheckBox.checkBoxLabel.text = "Heavy Sleep"
        sleepTimePicker.dataSource = self
        sleepTimePicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logSleepPressed(_ sender: UIButton) {
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
}
