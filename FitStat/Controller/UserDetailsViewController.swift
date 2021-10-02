//
//  UserDetailsViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 01.10.21.
//

import UIKit

class UserDetailsViewController: UIViewController, UsesUserDefault {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightUnitPicker: UIPickerView!
    @IBOutlet var heightUnitPicker: UIPickerView!
    
    var selectedWeightUnit: String?
    var selectedHeightUnit: String?
    
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
        weightUnitPicker.dataSource = self
        weightUnitPicker.delegate = self
        heightUnitPicker.dataSource = self
        heightUnitPicker.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstant.segueToMainView {
            let dest = segue.destination as! UITabBarController
            dest.modalPresentationStyle = .fullScreen
        }
    }

    @IBAction func continueButtonPressed(_ sender: UIButton) {
        let userDetails = [
            "name": nameTextField.text ?? "Mystery Donda",
            "weight": Float(weightTextField.text!) ?? 0,
            "height": Int(heightTextField.text!) ?? 0,
            "weightUnit": selectedWeightUnit ?? "Kilograms",
            "heightUnit": selectedHeightUnit ?? "centimeters"
            
        ] as [String : Any]
        saveUserDefaultValue(userDetails, for: AppConstant.userDetailsKey)
        performSegue(withIdentifier: AppConstant.segueToMainView, sender: self)
    }
}

extension UserDetailsViewController: UIPickerViewDataSource {
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

extension UserDetailsViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 100:
            return weightUnits[row]
        default:
            return heightUnits[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 100:
            selectedWeightUnit = weightUnits[row]
        default:
            selectedHeightUnit = heightUnits[row]
        }
    }
}

