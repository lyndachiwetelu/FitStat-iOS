//
//  ViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 25.08.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var weightView: UIStackView!
    @IBOutlet var moodView: UIStackView!
    @IBOutlet var sleepingView: UIStackView!
    @IBOutlet var foodView: UIStackView!
    @IBOutlet var workoutView: UIStackView!
    @IBOutlet var bodyMetricView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureRecognizers()
    }
    
    @objc func tap(_ gestureRecognizer: UITapGestureRecognizer) {
//        let tag = gestureRecognizer.view?.tag
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
            return "goToNextViewFood"
        case 200:
            return "goToNextViewSleep"
        case 300:
            return "goToNextViewMood"
        case 400:
            return "goToNextViewWeight"
        case 500:
            return "goToNextViewWorkout"
        case 600:
            return "goToNextViewMetric"
        default:
            return "goToNextViewFood"
        }
    }
    

}

