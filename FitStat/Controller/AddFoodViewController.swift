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
        healthyCheckBoxView.checkBoxLabel.text = "Healthy"
        unhealthyCheckBoxView.checkBoxLabel.text = "Unhealthy"
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
