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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func continueButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: AppConstant.segueToMainView, sender: self)
    }
}
