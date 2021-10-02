//
//  AddFoodViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit
import CoreData

class AddFoodViewController: UIViewController {

    @IBOutlet var healthyCheckBoxView: CheckBoxView!
    @IBOutlet var unhealthyCheckBoxView: CheckBoxView!
    @IBOutlet var foodTypePicker: UIPickerView!
    @IBOutlet var caloriesTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    
    var selectedFoodType: String?
    var healthy: String = "Healthy"
    
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
    }
    

    @IBAction func logFoodPressed(_ sender: UIButton) {
        var manager = CoreDataManager.shared
        let context = manager.persistentContainer.viewContext
        let food = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context) as! Food
        food.calories = Int16(Int(caloriesTextField.text ?? "")!)
        food.name = nameTextField.text ?? ""
        food.type = selectedFoodType ?? "Breakfast"
        food.time = Date()
        food.healthy = healthy == "Healthy"
        manager.saveContext()

        navigationController?.popViewController(animated: true)
    }

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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedFoodType = types[row]
    }
}

extension AddFoodViewController: CheckBoxViewDelegate {
    func checkBoxWasClicked(_ checkbox: CheckBoxView, with value: Bool) {
        if checkbox.checkBoxLabel.text! == "Healthy" {
            if value == true {
                healthy = "Healthy"
            }
            unhealthyCheckBoxView.change(to: !value)
        }
        
        if checkbox.checkBoxLabel.text! == "Unhealthy" {
            if value == true {
                healthy = "Unhealthy"
            }
            healthyCheckBoxView.change(to: !value)
        }
    }
    
}
