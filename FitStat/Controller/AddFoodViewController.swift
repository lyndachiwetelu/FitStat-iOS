//
//  AddFoodViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit

class AddFoodViewController: UIViewController {

    @IBOutlet var healthyCheckBoxView: CheckBoxView!
    @IBOutlet var unhealthyCheckBoxView: CheckBoxView!
    @IBOutlet var foodTypePicker: UIPickerView!
    
    var types = [
        "Breakfast",
        "Lunch",
        "Dinner",
        "Snack"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        healthyCheckBoxView.delegate = self
        unhealthyCheckBoxView.delegate = self
        foodTypePicker.delegate = self
        foodTypePicker.dataSource = self
        healthyCheckBoxView.checkBoxLabel.text = "Healthy"
        unhealthyCheckBoxView.checkBoxLabel.text = "Unhealthy"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func logFoodPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddFoodViewController:  UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
}

extension AddFoodViewController:  UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
}

extension AddFoodViewController: CheckBoxViewDelegate {
    func checkBoxWasClicked(_ checkbox: CheckBoxView, with value: Bool) {
        if checkbox.checkBoxLabel.text! == "Healthy" {
            unhealthyCheckBoxView.change(to: !value)
        }
        
        if checkbox.checkBoxLabel.text! == "Unhealthy" {
            healthyCheckBoxView.change(to: !value)
        }
    }
    
}
