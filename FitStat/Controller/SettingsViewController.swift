//
//  SettingsViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var foodLogIntervalPicker: UIPickerView!
    @IBOutlet var moodLogIntervalPicker: UIPickerView!
    @IBOutlet var bodyMetricLogIntervalPicker: UIPickerView!
    @IBOutlet var workoutLogIntervalPicker: UIPickerView!
    @IBOutlet var weightLogIntervalPicker: UIPickerView!
    @IBOutlet var sleepLogIntervalPicker: UIPickerView!
    
    var times = ["Everyday", "Every Monday", "Every Tuesday", "Every Wednesday", "Every Thursday", "Every Friday", "Every Saturday", "Every Sunday" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    func setDelegates() {
        let views = [foodLogIntervalPicker, moodLogIntervalPicker, bodyMetricLogIntervalPicker, workoutLogIntervalPicker, weightLogIntervalPicker, sleepLogIntervalPicker]
        for view in views {
            view?.delegate = self
            view?.dataSource = self
        }
        
    }
    
    @IBAction func saveRemindersPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }

}

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
    }
}

extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return times[row]
    }
    
}
