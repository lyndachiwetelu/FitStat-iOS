//
//  UserDetailsViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 01.10.21.
//

import UIKit

class UserDetailsViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
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
        weightUnitPicker.dataSource = self
        weightUnitPicker.delegate = self
        heightUnitPicker.dataSource = self
        heightUnitPicker.delegate = self
    }

    @IBAction func continueButtonPressed(_ sender: UIButton) {
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
}

