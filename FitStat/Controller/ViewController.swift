//
//  ViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 25.08.21.
//

import UIKit

class ViewController: UIViewController, UsesUserDefault {

    @IBOutlet var weightView: UIStackView!
    @IBOutlet var moodView: UIStackView!
    @IBOutlet var sleepingView: UIStackView!
    @IBOutlet var foodView: UIStackView!
    @IBOutlet var workoutView: UIStackView!
    @IBOutlet var bodyMetricView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureRecognizers()
        let user = getUserDefaultValue(for: AppConstant.userDetailsKey)!
        navigationItem.title = "FitStat: \(user["name"] ?? ""): \(user["weight"] ?? "")"
    }
    
    @objc func tap(_ gestureRecognizer: UITapGestureRecognizer) {
        blinkOpacity(for: gestureRecognizer.view)
        performTimedSegue(withId: getViewSegueId(tag: gestureRecognizer.view?.tag))
       
    }
    
    func addGestureRecognizers() {
        let views = [ weightView, moodView, sleepingView, foodView, workoutView, bodyMetricView ]
        for view in views {
            view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tap(_:))))
        }
    }
    
    func blinkOpacity(for view: UIView?) {
        view?.alpha = 0.5
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { timer in
            view?.alpha = 1
            timer.invalidate()
        }
    }
    
    func performTimedSegue(withId segueId: String) {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { timer in
            self.performSegue(withIdentifier: segueId, sender: self)
        }
    }
    
    func getViewSegueId(tag: Int?) -> String {
        switch tag {
        case 100:
            return AppConstant.segueToFoodView
        case 200:
            return AppConstant.segueToSleepView
        case 300:
            return AppConstant.segueToMoodView
        case 400:
            return AppConstant.segueToWeightView
        case 500:
            return AppConstant.segueToWorkoutView
        case 600:
            return AppConstant.segueToMetricView
        default:
            return AppConstant.segueToFoodView
        }
    }
    

}

