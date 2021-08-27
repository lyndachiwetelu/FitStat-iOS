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
    override func viewDidLoad() {
        super.viewDidLoad()
        lightSleepCheckBox.checkBoxLabel.text = "Light Sleep"
        heavySleepCheckBox.checkBoxLabel.text = "Heavy Sleep"

        // Do any additional setup after loading the view.
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
