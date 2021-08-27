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
    override func viewDidLoad() {
        super.viewDidLoad()
        healthyCheckBoxView.delegate = self
        unhealthyCheckBoxView.delegate = self
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
